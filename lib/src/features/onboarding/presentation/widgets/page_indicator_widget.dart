import 'package:flutter/material.dart';

class PageIndicatorWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color? activeColor;
  final Color? inactiveColor;
  final double activeWidth;
  final double inactiveWidth;
  final double height;

  const PageIndicatorWidget({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    this.activeColor,
    this.inactiveColor,
    this.activeWidth = 24,
    this.inactiveWidth = 8,
    this.height = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? activeWidth : inactiveWidth,
          height: height,
          decoration: BoxDecoration(
            color: currentPage == index
                ? (activeColor ?? Theme.of(context).primaryColor)
                : (inactiveColor ?? Colors.grey.shade300),
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ),
      ),
    );
  }
}