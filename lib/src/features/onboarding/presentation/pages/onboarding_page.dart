import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../widgets/onboarding_item_widget.dart';
import '../widgets/page_indicator_widget.dart';
import '../../../../routes/app_route_path.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      image: 'assets/images/boarding-1.png',
      titleKey: 'onboarding.title1',
      descriptionKey: 'onboarding.description1',
    ),
    OnboardingItem(
      image: 'assets/images/boarding-2.png',
      titleKey: 'onboarding.title2',
      descriptionKey: 'onboarding.description2',
    ),
    OnboardingItem(
      image: 'assets/images/boarding-3.png',
      titleKey: 'onboarding.title3',
      descriptionKey: 'onboarding.description3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _navigateToAuth(),
                    child: Text(
                      'onboarding.skip'.tr(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Page view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingItems.length,
                itemBuilder: (context, index) {
                  return OnboardingItemWidget(
                    image: _onboardingItems[index].image,
                    titleKey: _onboardingItems[index].titleKey,
                    descriptionKey: _onboardingItems[index].descriptionKey,
                  );
                },
              ),
            ),
            // Page indicator
            PageIndicatorWidget(
              currentPage: _currentPage,
              totalPages: _onboardingItems.length,
            ),
            const SizedBox(height: 32),
            // Navigation buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous button
                  _currentPage > 0
                      ? TextButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text(
                            'onboarding.previous'.tr(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : const SizedBox(width: 80),
                  // Next/Get Started button
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _onboardingItems.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _navigateToAuth();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      _currentPage < _onboardingItems.length - 1
                          ? 'onboarding.next'.tr()
                          : 'onboarding.getStarted'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  void _navigateToAuth() {
    // Navigate to authentication screen
    context.goNamed(AppRoute.login.name);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class OnboardingItem {
  final String image;
  final String titleKey;
  final String descriptionKey;

  OnboardingItem({
    required this.image,
    required this.titleKey,
    required this.descriptionKey,
  });
}