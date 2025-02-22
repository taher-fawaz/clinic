import 'package:clinic/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.textInputType,
      this.controller,
      this.suffixIcon,
      this.onSaved,
      this.maxLines,
      this.obscureText = false});
  final TextEditingController? controller;
  int? maxLines;
  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      obscureText: obscureText,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintStyle: TextStyles.bold13.copyWith(
          color: const Color(0xFF949D9E),
        ),
        hintText: hintText,
        filled: true,
        fillColor: const Color(0xFFF9FAFA),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xFFE6E9E9),
      ),
    );
  }
}
