import 'package:flutter/material.dart';
import 'package:clinic/core/utils/app_images.dart';
import 'package:clinic/features/on_boarding/presentation/views/widgets/page_view_item.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class OnBoardingPageview extends StatelessWidget {
  const OnBoardingPageview({super.key, required this.pageController});

  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        PageviewItem(
          isVisible: true,
          image: Assets.imagesBoarding3,
          subtitle:
              'نحن هنا لتقديم أفضل الخدمات الطبية لك ولعائلتك. استمتع بتجربة طبية مريحة وسهلة مع Ora Clinic',
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'مرحبًا بك في',
                style: TextStyles.bold23,
              ),
              Text(
                '  Ora',
                style: TextStyles.bold23.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
              Text(
                'Clinic',
                style: TextStyles.bold23.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        const PageviewItem(
          isVisible: false,
          image: Assets.imagesBoarding2,
          subtitle:
              'استمتع بتجربة طبية مريحة وسهلة مع Ora Clinic. نحن هنا لتقديم أفضل الخدمات الطبية لك ولعائلتك.',
          title: Text(
            'خدمات طبية مريحة وسهلة',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF0C0D0D),
              fontSize: 23,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        )
      ],
    );
  }
}
