import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/core/services/storage_service.dart';
import 'package:vignesh_project_01/features/chat/data/data_sources/chat_data_sources/chat_data_source.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat/chat_model.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat_response/chat_response_model.dart';
import 'package:vignesh_project_01/features/chat/data/models/participant/participant_model.dart';
import 'package:vignesh_project_01/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_response_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/participant_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/repositories/chat_repository.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_cubit.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_states.dart';

ChatModel _chat(String id, String otherName) => ChatModel(
  id: id,
  participants: [
    ParticipantModel(id: 'me', username: 'me'),
    ParticipantModel(id: 'u-$id', username: otherName),
  ],
);

final _cached = ChatResponseModel(
  chats: [_chat('c1', 'Alice'), _chat('c2', 'Bob'), _chat('c3', 'alina')],
);

class _FakeLocal extends Fake implements ChatLocalDataSource {
  final saved = <ChatResponseModel>[];

  @override
  Either<Failure, ChatResponseModel> getChatList() => Right(_cached);

  @override
  Future<void> saveChatList(ChatResponseModel model) async => saved.add(model);
}

class _FakeRemote extends Fake implements ChatRemoteDataSource {
  final searches = <String?>[];

  @override
  Future<Either<Failure, ChatResponseModel>> getChatList({
    String? search,
  }) async {
    searches.add(search);
    return Right(ChatResponseModel(chats: [_chat('c1', 'Alice')]));
  }
}

class _FakeStorage extends Fake implements StorageService {
  @override
  String? fetchUserId() => 'me';
}

ChatEntity _entity(String name) => ChatEntity(
  id: name,
  participant: ParticipantEntity(id: name, username: name, email: null),
);

/// Cached results are immediate; each sync waits on its own completer.
class _FakeRepo extends Fake implements ChatRepository {
  final syncs = <String?, Completer<Either<Failure, ChatResponseEntity>>>{};

  @override
  Either<Failure, ChatResponseEntity> getChatList({String? search}) =>
      Right(ChatResponseEntity(chats: [_entity('cached:${search ?? ''}')]));

  @override
  Future<Either<Failure, ChatResponseEntity>> syncChatList({String? search}) =>
      (syncs[search] = Completer()).future;
}

List<String?> _ids(ChatCubit c) =>
    (c.state as ChatListLoaded).chats.map((e) => e.id).toList();

void main() {
  group('ChatRepositoryImpl search', () {
    late _FakeLocal local;
    late _FakeRemote remote;
    late ChatRepositoryImpl repo;

    setUp(() {
      local = _FakeLocal();
      remote = _FakeRemote();
      repo = ChatRepositoryImpl(
        chatRemoteDataSource: remote,
        chatLocalDataSource: local,
        storageService: _FakeStorage(),
      );
    });

    List<String?> names(Either<Failure, ChatResponseEntity> r) => r
        .getOrElse((_) => throw 'failed')
        .chats!
        .map((c) => c.participant?.username)
        .toList();

    test('cached list is filtered by participant name, case-insensitive', () {
      expect(names(repo.getChatList(search: 'ALI')), ['Alice', 'alina']);
      expect(names(repo.getChatList(search: '  bob ')), ['Bob']);
      expect(
        names(repo.getChatList(search: 'me')),
        isEmpty,
        reason: 'not my own name',
      );
      expect(names(repo.getChatList()), hasLength(3));
      expect(names(repo.getChatList(search: '')), hasLength(3));
    });

    test(
      'sync passes the search term and does not cache filtered results',
      () async {
        await repo.syncChatList(search: ' ali ');
        expect(remote.searches, ['ali']);
        expect(local.saved, isEmpty);
      },
    );

    test('unfiltered sync is cached', () async {
      await repo.syncChatList();
      expect(remote.searches, [null]);
      expect(local.saved, hasLength(1));
    });
  });

  group('ChatCubit.getChatList', () {
    late _FakeRepo repo;
    late ChatCubit cubit;

    setUp(() {
      repo = _FakeRepo();
      cubit = ChatCubit(chatRepository: repo);
    });

    test('shows cached results immediately, then the server results', () async {
      final load = cubit.getChatList(search: 'al');
      expect(_ids(cubit), ['cached:al']);
      expect((cubit.state as ChatListLoaded).isSyncing, isTrue);

      repo.syncs['al']!.complete(
        Right(ChatResponseEntity(chats: [_entity('server:al')])),
      );
      await load;
      expect(_ids(cubit), ['server:al']);
      expect((cubit.state as ChatListLoaded).isSyncing, isFalse);
    });

    test('never switches to the full-screen loader while searching', () async {
      final states = <ChatListState>[];
      final sub = cubit.stream.listen(states.add);

      unawaited(cubit.getChatList(search: 'a'));
      unawaited(cubit.getChatList(search: 'ab'));
      await Future<void>.delayed(Duration.zero);

      expect(states.whereType<ChatListLoading>(), isEmpty);
      await sub.cancel();
    });

    test('a slower, older search cannot overwrite a newer one', () async {
      final older = cubit.getChatList(search: 'a');
      final newer = cubit.getChatList(search: 'ab');

      repo.syncs['ab']!.complete(
        Right(ChatResponseEntity(chats: [_entity('server:ab')])),
      );
      await newer;
      repo.syncs['a']!.complete(
        Right(ChatResponseEntity(chats: [_entity('server:a')])),
      );
      await older;

      expect(_ids(cubit), ['server:ab']);
    });

    test('sync failure keeps the filtered cached results', () async {
      final load = cubit.getChatList(search: 'al');
      repo.syncs['al']!.complete(Left(Failure(message: 'offline')));
      await load;

      expect(_ids(cubit), ['cached:al']);
      expect((cubit.state as ChatListLoaded).isSyncing, isFalse);
    });
  });
}
