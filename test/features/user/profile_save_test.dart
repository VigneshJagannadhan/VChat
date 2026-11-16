import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/core/themes/chat_colors.dart';
import 'package:vignesh_project_01/features/user/domain/entities/user_entity.dart';
import 'package:vignesh_project_01/features/user/domain/repositories/user_repository.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user/user_cubit.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user/user_states.dart';
import 'package:vignesh_project_01/features/user/presentation/views/user_profile_view.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/locale/locale_cubit.dart';

const _alice = UserEntity(id: 'u1', name: 'Alice', email: 'alice@example.com');

/// Cached profile is [_alice]; sync and update wait on completers.
class _FakeUserRepository extends Fake implements UserRepository {
  final updates = <String>[];
  Completer<Either<Failure, UserEntity>>? sync;
  Completer<Either<Failure, UserEntity>>? update;

  @override
  Either<Failure, UserEntity> getProfileDetail() => const Right(_alice);

  @override
  Future<Either<Failure, UserEntity>> syncProfileDetail() =>
      (sync = Completer()).future;

  @override
  Future<Either<Failure, UserEntity>> updateProfile({required String name}) {
    updates.add(name);
    return (update = Completer()).future;
  }
}

UserLoaded _loaded(UserCubit c) => c.state as UserLoaded;

void main() {
  late _FakeUserRepository repo;
  setUp(() => repo = _FakeUserRepository());

  group('UserCubit.updateProfile', () {
    test('saving then success replaces the user', () async {
      final cubit = UserCubit(userRepository: repo)..getUserDetail();
      final save = cubit.updateProfile(name: '  Bob  ');

      expect(_loaded(cubit).isSaving, isTrue);
      expect(repo.updates, ['Bob'], reason: 'trimmed');

      repo.update!.complete(
        const Right(
          UserEntity(id: 'u1', name: 'Bob', email: 'alice@example.com'),
        ),
      );
      await save;
      expect(_loaded(cubit).isSaving, isFalse);
      expect(_loaded(cubit).user.name, 'Bob');
      expect(_loaded(cubit).saveFailure, isNull);
    });

    test('failure keeps the old user and reports the failure', () async {
      final cubit = UserCubit(userRepository: repo)..getUserDetail();
      final save = cubit.updateProfile(name: 'Bob');
      repo.update!.complete(Left(Failure(message: 'taken', errorCode: '409')));
      await save;

      expect(_loaded(cubit).user, _alice);
      expect(_loaded(cubit).saveFailure?.errorCode, '409');
    });

    test('ignores a second save while one is in flight', () async {
      final cubit = UserCubit(userRepository: repo)..getUserDetail();
      unawaited(cubit.updateProfile(name: 'Bob'));
      await cubit.updateProfile(name: 'Carol');
      expect(repo.updates, ['Bob']);
    });
  });

  group('UserProfileView', () {
    late UserCubit cubit;

    Future<void> pumpView(WidgetTester tester) async {
      cubit = UserCubit(userRepository: repo);
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(value: cubit),
            BlocProvider(create: (_) => LocaleCubit()),
          ],
          child: MaterialApp(
            theme: ThemeData(extensions: const [ChatColors.dark]),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const UserProfileView(),
          ),
        ),
      );
      await tester.pump();
    }

    Finder field(String label) => find.widgetWithText(TextField, label);
    String text(WidgetTester t, String label) =>
        t.widget<TextField>(field(label)).controller!.text;
    FilledButton saveButton(WidgetTester t) => t.widget<FilledButton>(
      find.descendant(
        of: find.bySemanticsLabel('Save'),
        matching: find.byType(FilledButton),
      ),
    );

    testWidgets('shows the profile; email is read-only; save starts disabled', (
      tester,
    ) async {
      await pumpView(tester);

      expect(text(tester, 'Name'), 'Alice');
      expect(text(tester, 'Email'), 'alice@example.com');
      expect(tester.widget<TextField>(field('Email')).enabled, isFalse);
      expect(saveButton(tester).onPressed, isNull);
    });

    testWidgets('saves a changed name and confirms', (tester) async {
      await pumpView(tester);
      await tester.enterText(field('Name'), 'Bob');
      await tester.pump();
      expect(saveButton(tester).onPressed, isNotNull);

      await tester.tap(find.bySemanticsLabel('Save'));
      await tester.pump();
      expect(repo.updates, ['Bob']);

      repo.update!.complete(
        const Right(
          UserEntity(id: 'u1', name: 'Bob', email: 'alice@example.com'),
        ),
      );
      await tester.pump();
      await tester.pump();
      expect(find.text('Profile updated'), findsOneWidget);
      expect(text(tester, 'Name'), 'Bob');
      expect(
        saveButton(tester).onPressed,
        isNull,
        reason: 'no unsaved changes',
      );
    });

    testWidgets('invalid name is not sent', (tester) async {
      await pumpView(tester);
      await tester.enterText(field('Name'), 'Bob123');
      await tester.pump();
      await tester.tap(find.bySemanticsLabel('Save'));
      await tester.pump();

      expect(repo.updates, isEmpty);
      expect(find.text('Enter a valid name'), findsOneWidget);
    });

    testWidgets('taken name shows a message and keeps the edit', (
      tester,
    ) async {
      await pumpView(tester);
      await tester.enterText(field('Name'), 'Bob');
      await tester.pump();
      await tester.tap(find.bySemanticsLabel('Save'));
      await tester.pump();

      repo.update!.complete(Left(Failure(message: 'x', errorCode: '409')));
      await tester.pump();
      await tester.pump();
      expect(find.text('That name is already taken'), findsOneWidget);
      expect(text(tester, 'Name'), 'Bob');
    });

    testWidgets('background sync does not wipe an edit', (tester) async {
      await pumpView(tester);
      await tester.enterText(field('Name'), 'Typing');
      await tester.pump();

      repo.sync!.complete(const Right(_alice));
      await tester.pump();
      expect(text(tester, 'Name'), 'Typing');
    });

    testWidgets('background sync updates an untouched field', (tester) async {
      await pumpView(tester);
      repo.sync!.complete(
        const Right(
          UserEntity(id: 'u1', name: 'Alicia', email: 'alice@example.com'),
        ),
      );
      await tester.pump();
      expect(text(tester, 'Name'), 'Alicia');
    });
  });
}
