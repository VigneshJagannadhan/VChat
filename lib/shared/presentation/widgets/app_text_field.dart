import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';

enum _AppTextFieldKind { standard, password, search }

/// The app's only text input. Styling (fill, border, label colors) comes
/// from the theme's `inputDecorationTheme`; this widget only shapes the API.
///
/// Tapping outside the field dismisses the keyboard. Taps on other text
/// fields, or on widgets wrapped in [TextFieldTapRegion] (e.g. a chat send
/// button), count as inside, so they don't close the keyboard.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.minLines,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : _kind = _AppTextFieldKind.standard,
       debounce = Duration.zero;

  const AppTextField.password({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.enabled = true,
    this.autofocus = false,
    this.textInputAction,
    this.autofillHints = const [AutofillHints.password],
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : _kind = _AppTextFieldKind.password,
       prefixIcon = null,
       suffixIcon = null,
       keyboardType = TextInputType.visiblePassword,
       readOnly = false,
       minLines = null,
       maxLines = 1,
       textCapitalization = TextCapitalization.none,
       debounce = Duration.zero;

  /// Search input. [onChanged] is debounced by [debounce], so callers can
  /// hit the API directly from it.
  const AppTextField.search({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.onChanged,
    this.focusNode,
    this.enabled = true,
    this.autofocus = false,
    this.debounce = const Duration(milliseconds: 500),
  }) : _kind = _AppTextFieldKind.search,
       prefixIcon = Icons.search,
       suffixIcon = null,
       keyboardType = TextInputType.text,
       textInputAction = TextInputAction.search,
       validator = null,
       onFieldSubmitted = null,
       readOnly = false,
       minLines = null,
       maxLines = 1,
       textCapitalization = TextCapitalization.none,
       autofillHints = null,
       autovalidateMode = AutovalidateMode.disabled;

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int? minLines;
  final int? maxLines;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final AutovalidateMode autovalidateMode;

  /// Only used by [AppTextField.search].
  final Duration debounce;
  final _AppTextFieldKind _kind;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscured = true;
  Timer? _debounceTimer;

  bool get _isPassword => widget._kind == _AppTextFieldKind.password;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handleChanged(String value) {
    final onChanged = widget.onChanged;
    if (onChanged == null) return;
    if (widget.debounce == Duration.zero) {
      onChanged(value);
      return;
    }
    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounce, () => onChanged(value));
  }

  void _toggleObscured() {
    HapticFeedback.selectionClick();
    setState(() => _obscured = !_obscured);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      obscureText: _isPassword && _obscured,
      enableSuggestions: !_isPassword,
      autocorrect: !_isPassword,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      textCapitalization: widget.textCapitalization,
      autofillHints: widget.autofillHints,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      onChanged: _handleChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: _isPassword
            ? IconButton(
                icon: Icon(_obscured ? Icons.visibility_off : Icons.visibility),
                tooltip: _obscured
                    ? l10n.showPasswordTooltip
                    : l10n.hidePasswordTooltip,
                onPressed: _toggleObscured,
              )
            : widget.suffixIcon,
      ),
    );
  }
}
