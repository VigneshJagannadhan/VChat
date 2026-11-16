import 'package:flutter/material.dart';

/// The app's only scaffold.
///
/// - [body] and [bottomNavigationBar] are wrapped in [SafeArea], so content
///   clears notches, the home indicator and Android 3-button navigation
///   without per-screen padding.
/// - [banner] is rendered above [body], under [appBar] (e.g. [AppSyncBanner]),
///   so every screen shows status banners in the same place.
/// - Keyboard dismissal is handled by [AppTextField] (tap outside), not here,
///   so taps on things like a chat send button don't close the keyboard.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.banner,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.scrollable = false,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? banner;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;

  /// Wraps [body] in a scroll view that is at least viewport-tall, so forms
  /// stay centered on tall screens and scroll when the keyboard opens.
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final content = scrollable ? _ScrollableBody(child: body) : body;
    final banner = this.banner;
    final bottomNavigationBar = this.bottomNavigationBar;

    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar == null
          ? null
          : SafeArea(child: bottomNavigationBar),
      body: SafeArea(
        child: banner == null
            ? content
            : Column(
                children: [
                  banner,
                  Expanded(child: content),
                ],
              ),
      ),
    );
  }
}

class _ScrollableBody extends StatelessWidget {
  const _ScrollableBody({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: child,
        ),
      ),
    );
  }
}
