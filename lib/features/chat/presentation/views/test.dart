import 'package:flutter/material.dart';

class AkTextFormField extends StatelessWidget {
  const AkTextFormField({
    super.key,
    required this.controller,
    this.onChanged,
    required this.label,
    this.labelStyle,
    this.borderWidth,
    this.borderRadius,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onChanged;
  final TextStyle? labelStyle;
  final double? borderWidth;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (value) => onChanged!(value),
      validator: (value) => validator!(value),
      decoration: InputDecoration(
        label: Text(label, style: labelStyle),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth ?? 0.1),
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
        ),
      ),
    );
  }
}
