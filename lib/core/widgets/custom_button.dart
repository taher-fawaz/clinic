import 'package:clinic/core/utils/app_colors.dart';
import 'package:clinic/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key, required this.onPressed, required this.text, this.color,this.width});
  final VoidCallback onPressed;
  double? width;
  Color? color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:width?? double.infinity,
      height: 54,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          backgroundColor: color ?? AppColors.primaryColor,
          foregroundColor: Colors.white, //
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyles.bold16.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
