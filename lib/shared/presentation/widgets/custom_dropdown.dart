import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.dropdownList,
    required this.value,
    this.onChanged,
    required this.label,
    this.validator,
  });

  final List<DropdownMenuItem<T>> dropdownList;
  final T value;
  final String label;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      ),
      initialValue: value,
      items: dropdownList,
      onChanged: onChanged,
    );
  }
}
