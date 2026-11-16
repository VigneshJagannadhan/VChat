import 'package:flutter/material.dart';

/// The app's only dropdown. Built on Material's [DropdownMenu], so it shares
/// the input styling from `inputDecorationTheme` and gets keyboard and
/// screen-reader support for free.
class AppDropdownField<T> extends StatelessWidget {
  const AppDropdownField({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.label,
    this.hint,
    this.labelBuilder,
    this.enabled = true,
  });

  final List<T> items;
  final ValueChanged<T> onChanged;
  final T? value;
  final String? label;
  final String? hint;

  /// Text for each item. Defaults to `toString()`.
  final String Function(T item)? labelBuilder;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      initialSelection: value,
      enabled: enabled,
      label: label == null ? null : Text(label!),
      hintText: hint,
      expandedInsets: EdgeInsets.zero,
      requestFocusOnTap: false,
      onSelected: (selected) {
        if (selected != null) onChanged(selected);
      },
      dropdownMenuEntries: [
        for (final item in items)
          DropdownMenuEntry<T>(
            value: item,
            label: labelBuilder?.call(item) ?? item.toString(),
          ),
      ],
    );
  }
}
