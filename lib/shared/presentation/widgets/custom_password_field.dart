import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';

class CustomPasswordField extends StatelessWidget {
  CustomPasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _obscureText,
      builder: (context, obscureText, _) {
        return TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            label: Text(label, style: AppStyles.ts16W400cBlack),
            border: OutlineInputBorder(),

            suffixIcon: GestureDetector(
              onTap: () {
                HapticFeedback.heavyImpact();
                _obscureText.value = !obscureText;
              },
              child: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: obscureText ? Colors.grey : Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }
}
