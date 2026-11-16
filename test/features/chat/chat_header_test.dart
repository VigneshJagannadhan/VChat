import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vignesh_project_01/core/routes/app_args.dart';
import 'package:vignesh_project_01/core/routes/app_routes.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/participant_entity.dart';
import 'package:vignesh_project_01/features/chat/presentation/views/chat_view.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/chat_view_appbar.dart';

const _alice = ParticipantEntity(
  id: 'u1',
  username: 'alice',
  email: 'alice@example.com',
);

void main() {
  test('chat list and header use the same display name', () {
    const chat = ChatEntity(id: 'c1', participant: _alice);
    expect(_alice.displayName, 'ALICE');
    expect(chat.participantName, _alice.displayName);
  });

  test('chat route passes the participant to ChatView', () {
    final route =
        onGenerateRoute(
              RouteSettings(
                name: ChatView.route,
                arguments: ChatDetailViewArgs(
                  chatId: 'c1',
                  participant: _alice,
                ),
              ),
            )
            as MaterialPageRoute;

    // ChatView's constructor doesn't use the context.
    final view = route.builder(_FakeContext()) as ChatView;
    expect(view.chatId, 'c1');
    expect(view.participant, _alice);
  });

  testWidgets('header shows the participant name and no fake last seen', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(appBar: ChatViewAppBar(name: _alice.displayName)),
      ),
    );

    expect(find.text('ALICE'), findsOneWidget);
    expect(find.textContaining('Jake'), findsNothing);
    expect(find.textContaining('Last seen'), findsNothing);
  });
}

class _FakeContext extends Fake implements BuildContext {}
