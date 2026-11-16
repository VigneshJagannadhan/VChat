import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/core/themes/chat_colors.dart';
import 'package:vignesh_project_01/core/utils/enums.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat_response/chat_response_model.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_detail_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/message_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/repositories/chat_repository.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_cubit.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_states.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/message_bubble.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';

/// Each send waits on a completer the test resolves.
class _FakeChatRepository extends Fake implements ChatRepository {
  final sends = <String>[];
  final _pending = <Completer<Either<Failure, ChatResponseModel>>>[];
  Completer<Either<Failure, ChatDetailEntity>>? syncCompleter;

  @override
  Future<Either<Failure, ChatResponseModel>> sendMessage({
    required String userId,
    required String content,
  }) {
    sends.add(content);
    final c = Completer<Either<Failure, ChatResponseModel>>();
    _pending.add(c);
    return c.future;
  }

  void succeedNext() =>
      _pending.removeAt(0).complete(Right(ChatResponseModel()));
  void failNext() =>
      _pending.removeAt(0).complete(Left(Failure(message: 'offline')));

  @override
  Either<Failure, ChatDetailEntity> getChatDetail({required String id}) =>
      Right(ChatDetailEntity(messages: const []));

  @override
  Future<Either<Failure, ChatDetailEntity>> syncChatDetail({
    required String id,
  }) => (syncCompleter = Completer()).future;
}

List<MessageEntity> _messages(ChatDetailCubit c) =>
    (c.state as ChatDetailLoaded).messages;

ChatDetailCubit _loadedCubit(_FakeChatRepository repo) =>
    ChatDetailCubit(chatRepository: repo)..emit(
      const ChatDetailLoaded(messages: [], isTyping: false, isSyncing: false),
    );

void main() {
  late _FakeChatRepository repo;
  setUp(() => repo = _FakeChatRepository());

  group('ChatDetailCubit.sendMessage', () {
    test('shows pending, then success', () async {
      final cubit = _loadedCubit(repo);
      final send = cubit.sendMessage(chatId: 'c1', content: '  hi  ');

      expect(_messages(cubit).single.status, MessageStatus.pending);
      expect(_messages(cubit).single.content, 'hi', reason: 'trimmed');

      repo.succeedNext();
      await send;
      expect(_messages(cubit).single.status, MessageStatus.success);
    });

    test('failure marks failed; retry resends the same message', () async {
      final cubit = _loadedCubit(repo);
      final send = cubit.sendMessage(chatId: 'c1', content: 'hi');
      repo.failNext();
      await send;

      final failed = _messages(cubit).single;
      expect(failed.status, MessageStatus.failed);

      final retry = cubit.retryMessage(failed);
      expect(_messages(cubit).single.status, MessageStatus.pending);
      repo.succeedNext();
      await retry;

      expect(_messages(cubit), hasLength(1), reason: 'no duplicate bubble');
      expect(_messages(cubit).single.status, MessageStatus.success);
      expect(repo.sends, ['hi', 'hi']);
    });

    test('ignores blank messages', () async {
      final cubit = _loadedCubit(repo);
      await cubit.sendMessage(chatId: 'c1', content: '   ');
      expect(repo.sends, isEmpty);
      expect(_messages(cubit), isEmpty);
    });

    test('does not send while the chat has not loaded', () async {
      final cubit = ChatDetailCubit(chatRepository: repo);
      expect(cubit.canSend, isFalse);
      await cubit.sendMessage(chatId: 'c1', content: 'hi');
      expect(repo.sends, isEmpty);
    });

    test('response after leaving the chat does not crash', () async {
      final cubit = _loadedCubit(repo);
      final send = cubit.sendMessage(chatId: 'c1', content: 'hi');
      cubit.emit(const ChatDetailLoading()); // opened another chat

      repo.failNext();
      await expectLater(send, completes);
    });

    test('a sync finishing mid-send keeps the unsent message', () async {
      final cubit = _loadedCubit(repo);
      final load = cubit.getChatDetail(id: 'c1'); // cached: empty, syncing
      final send = cubit.sendMessage(chatId: 'c1', content: 'hi');

      repo.syncCompleter!.complete(
        Right(
          ChatDetailEntity(
            messages: const [
              MessageEntity(id: 's1', content: 'old', isSentByMe: false),
            ],
          ),
        ),
      );
      await load;
      expect(_messages(cubit).map((m) => m.content), ['hi', 'old']);

      repo.succeedNext();
      await send;
      expect(_messages(cubit).first.status, MessageStatus.success);
    });
  });

  group('MessageBubble', () {
    testWidgets('failed bubble shows retry label and retries on tap', (
      tester,
    ) async {
      final cubit = _loadedCubit(repo);
      final send = cubit.sendMessage(chatId: 'c1', content: 'hi');
      repo.failNext();
      await send;

      await tester.pumpWidget(
        BlocProvider.value(
          value: cubit,
          child: MaterialApp(
            theme: ThemeData(extensions: const [ChatColors.dark]),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: BlocBuilder<ChatDetailCubit, ChatDetailState>(
                builder: (_, state) => MessageBubble(
                  message: (state as ChatDetailLoaded).messages.single,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Not sent. Tap to retry'), findsOneWidget);
      await tester.tap(find.text('hi'));
      await tester.pump();
      expect(repo.sends, ['hi', 'hi']);
      expect(find.text('Not sent. Tap to retry'), findsNothing);

      repo.succeedNext();
      await tester.pumpAndSettle();
    });
  });
}
