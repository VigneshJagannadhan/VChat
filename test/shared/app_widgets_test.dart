import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vignesh_project_01/core/themes/chat_colors.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_button.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_empty_view.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_error_view.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_scaffold.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_text_field.dart';

/// Plain theme (not AppTheme) so tests don't fetch Google Fonts.
Widget _host(Widget child) => MaterialApp(
  theme: ThemeData(extensions: const [ChatColors.dark]),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: child,
);

void main() {
  group('AppButton', () {
    testWidgets('announces its label once and is tappable', (tester) async {
      final handle = tester.ensureSemantics();
      var taps = 0;
      await tester.pumpWidget(
        _host(
          AppScaffold(
            body: AppButton.primary(label: 'Login', onPressed: () => taps++),
          ),
        ),
      );

      expect(
        find.bySemanticsLabel('Login'),
        findsOneWidget,
        reason: 'inner button semantics must be excluded',
      );
      await tester.tap(find.byType(AppButton));
      expect(taps, 1);
      handle.dispose();
    });

    testWidgets('ignores taps and shows a spinner while loading', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpWidget(
        _host(
          AppScaffold(
            body: AppButton.primary(
              label: 'Login',
              isLoading: true,
              onPressed: () => taps++,
            ),
          ),
        ),
      );

      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
      await tester.tap(find.byType(AppButton), warnIfMissed: false);
      expect(taps, 0);
    });

    testWidgets('fits inside a Row when not full width', (tester) async {
      await tester.pumpWidget(
        _host(
          AppScaffold(
            body: Row(
              children: [
                AppButton.text(label: 'A', onPressed: () {}),
                AppButton.primary(
                  label: 'B',
                  fullWidth: false,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('AppTextField', () {
    testWidgets('search debounces onChanged', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(
        _host(AppScaffold(body: AppTextField.search(onChanged: calls.add))),
      );

      await tester.enterText(find.byType(TextField), 'a');
      await tester.pump(const Duration(milliseconds: 200));
      await tester.enterText(find.byType(TextField), 'ab');
      await tester.pump(const Duration(milliseconds: 200));
      expect(calls, isEmpty);

      await tester.pump(const Duration(milliseconds: 500));
      expect(calls, ['ab']);
    });

    testWidgets('password toggles visibility', (tester) async {
      await tester.pumpWidget(
        _host(const AppScaffold(body: AppTextField.password(label: 'Pw'))),
      );

      bool obscured() =>
          tester.widget<TextField>(find.byType(TextField)).obscureText;
      expect(obscured(), isTrue);
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();
      expect(obscured(), isFalse);
    });

    testWidgets('tapping outside dismisses the keyboard', (tester) async {
      await tester.pumpWidget(
        _host(
          const AppScaffold(
            body: Column(
              children: [
                AppTextField(label: 'Name'),
                Expanded(child: SizedBox.expand()),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pump();
      expect(tester.testTextInput.isVisible, isTrue);

      await tester.tapAt(const Offset(200, 500));
      await tester.pump();
      expect(tester.testTextInput.isVisible, isFalse);
    });

    testWidgets('TextFieldTapRegion keeps the keyboard open', (tester) async {
      var sent = 0;
      await tester.pumpWidget(
        _host(
          AppScaffold(
            body: Row(
              children: [
                const Expanded(child: AppTextField(label: 'Message')),
                TextFieldTapRegion(
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => sent++,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();
      expect(sent, 1);
      expect(tester.testTextInput.isVisible, isTrue);
    });
  });

  group('state views', () {
    testWidgets('error view works directly as a scaffold body', (
      tester,
    ) async {
      // Regression: the old CustomErrorWidget returned an Expanded, which
      // threw "Incorrect use of ParentDataWidget" here.
      await tester.pumpWidget(
        _host(AppScaffold(body: AppErrorView(message: 'Oops', onRetry: () {}))),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('Oops'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('empty view works inside Expanded', (tester) async {
      await tester.pumpWidget(
        _host(
          const AppScaffold(
            body: Column(
              children: [
                Text('header'),
                Expanded(child: AppEmptyView(message: 'Nothing here')),
              ],
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('Nothing here'), findsOneWidget);
    });
  });
}
