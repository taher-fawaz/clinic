import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final Animation<double> fadeAnimation;

  const LoadingIndicatorWidget({
    Key? key,
    required this.fadeAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Column(
          children: [
            Text(
              'splash.loading'.tr(),
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}