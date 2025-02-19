import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:clinic/core/utils/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../constants.dart';
import '../../../../../core/services/shared_preferences_singleton.dart';

class PageviewItem extends StatelessWidget {
  const PageviewItem(
      {super.key,
      required this.image,
      required this.subtitle,
      required this.title,
      required this.isVisible});

  final String image;
  final String subtitle;
  final Widget title;

  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Positioned(
          right: 0,
          top: 0,
          child: Visibility(
            visible: isVisible,
            child: GestureDetector(
              onTap: () {
                // Prefs.setBool(kIsOnBoardingViewSeen, true);

                // Navigator.of(context).pushReplacementNamed(
                //   SigninView.routeName,
                // );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'تخط',
                  style: TextStyles.bold13.copyWith(
                    color: const Color.fromARGB(255, 58, 58, 58),
                  ),
                ),
              ),
            ),
          ),
        ),
        Image.asset(
          image,
          width: 400,
          height: 300,
          fit: BoxFit.cover,
        ),
        title,
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 37,
          ),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyles.semiBold13.copyWith(
              color: const Color(0xFF4E5456),
            ),
          ),
        ),
      ],
    );
  }
}
