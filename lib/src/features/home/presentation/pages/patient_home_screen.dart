import 'package:clinic/src/core/res/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../data/models/doctor_work_model.dart';
import '../../data/models/article_model.dart';
import '../widgets/doctor_work_carousel.dart';
import '../widgets/article_card.dart';
import '../../../../widgets/button_widget.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      padding: EdgeInsets.only(top: 8.h),
      backgroundColor: ColorManager.surface,
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight + 10.h,
      navBarStyle: NavBarStyle.style12,
    );
  }

  List<Widget> _buildScreens() {
    return [
      const _HomeTab(),
      const _AppointmentsTab(),
      const _ArticlesTab(),
      const _ProfileTab(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.home_outlined),
        icon: const Icon(Icons.home),
        title: 'home.bottomNav.home'.tr(),
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: ColorManager.textSecondary,
        textStyle: TextStyleManager.getRegularStyle(
          fontSize: FontSize.s12,
        ),
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.calendar_today_outlined),
        icon: const Icon(Icons.calendar_today),
        title: 'home.bottomNav.appointments'.tr(),
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: ColorManager.textSecondary,
        textStyle: TextStyleManager.getRegularStyle(
          fontSize: FontSize.s12,
        ),
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.article_outlined),
        icon: const Icon(Icons.article),
        title: 'home.bottomNav.articles'.tr(),
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: ColorManager.textSecondary,
        textStyle: TextStyleManager.getRegularStyle(
          fontSize: FontSize.s12,
        ),
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.person_outline),
        icon: const Icon(Icons.person),
        title: 'home.bottomNav.profile'.tr(),
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: ColorManager.textSecondary,
        textStyle: TextStyleManager.getRegularStyle(
          fontSize: FontSize.s12,
        ),
      ),
    ];
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundPrimary,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120.h,
            floating: false,
            pinned: true,
            backgroundColor: ColorManager.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'home.welcome'.tr(),
                style: TextStyleManager.getSemiBoldStyle(
                  fontSize: FontSize.s18,
                  color: ColorManager.onPrimary,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: ColorManager.primaryGradient,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'home.welcome'.tr(),
                              style: TextStyleManager.getSemiBoldStyle(
                                fontSize: FontSize.s24,
                                color: ColorManager.onPrimary,
                              ),
                            ),
                            Text(
                              'John Doe', // This should come from user data
                              style: TextStyleManager.getRegularStyle(
                                fontSize: FontSize.s16,
                                color: ColorManager.onPrimary.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.onPrimary.withOpacity(0.2),
                          ),
                          child: Icon(
                            Icons.notifications_outlined,
                            color: ColorManager.onPrimary,
                            size: 24.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 24.h),
                // Doctor Work Carousel
                DoctorWorkCarousel(
                  doctorWorks: _getMockDoctorWorks(),
                  onViewAll: () {
                    // Navigate to doctor works page
                  },
                ),
                SizedBox(height: 32.h),
                // Book Appointment CTA
                _BookAppointmentSection(),
                SizedBox(height: 32.h),
                // Articles Section
                _ArticlesSection(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<DoctorWorkModel> _getMockDoctorWorks() {
    return [
      DoctorWorkModel(
        id: '1',
        title: 'Dental Implant Restoration',
        description:
            'Complete dental implant with crown restoration for missing tooth.',
        beforeImageUrl: 'https://picsum.photos/400/300?random=1',
        afterImageUrl: 'https://picsum.photos/400/300?random=2',
        doctorName: 'Dr. Sarah Ahmed',
        specialty: 'Dentistry',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        tags: ['Implant', 'Restoration'],
      ),
      DoctorWorkModel(
        id: '2',
        title: 'Skin Rejuvenation Treatment',
        description:
            'Advanced laser treatment for skin rejuvenation and anti-aging.',
        beforeImageUrl: 'https://picsum.photos/400/300?random=3',
        afterImageUrl: 'https://picsum.photos/400/300?random=4',
        doctorName: 'Dr. Ahmed Hassan',
        specialty: 'Dermatology',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        tags: ['Laser', 'Anti-aging'],
      ),
    ];
  }
}

class _BookAppointmentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: ColorManager.secondaryGradient,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'home.appointment.title'.tr(),
            style: TextStyleManager.getBoldStyle(
              fontSize: FontSize.s20,
              color: ColorManager.onSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'home.appointment.subtitle'.tr(),
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.onSecondary.withOpacity(0.9),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: AppButtonWidget(
              callback: () {
                // Navigate to appointment booking
              },
              label: 'home.appointment.bookNow'.tr(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticlesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final articles = _getMockArticles();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'home.articles.title'.tr(),
                style: TextStyleManager.getBoldStyle(
                  fontSize: FontSize.s18,
                  color: ColorManager.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to articles page
                },
                child: Text(
                  'home.articles.viewAll'.tr(),
                  style: TextStyleManager.getMediumStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: articles.map((article) {
              return ArticleCard(
                article: article,
                onTap: () {
                  // Navigate to article details
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  List<ArticleModel> _getMockArticles() {
    return [
      ArticleModel(
        id: '1',
        title: '10 Tips for Better Oral Health',
        shortDescription:
            'Discover essential tips to maintain excellent oral hygiene and prevent dental problems.',
        content: 'Full article content here...',
        thumbnailUrl: 'https://picsum.photos/300/200?random=5',
        authorName: 'Dr. Sarah Ahmed',
        authorImageUrl: 'https://picsum.photos/100/100?random=6',
        publishedAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        tags: ['Oral Health', 'Prevention', 'Tips'],
        readTimeMinutes: 5,
        isFeatured: true,
      ),
      ArticleModel(
        id: '2',
        title: 'Understanding Skin Care Routines',
        shortDescription:
            'Learn about effective skin care routines for different skin types and conditions.',
        content: 'Full article content here...',
        thumbnailUrl: 'https://picsum.photos/300/200?random=9',
        authorName: 'Dr. Fatima Al-Zahra',
        authorImageUrl: 'https://picsum.photos/100/100?random=10',
        publishedAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 4)),
        tags: ['Skin Care', 'Dermatology', 'Health'],
        readTimeMinutes: 8,
        isFeatured: false,
      ),
    ];
  }
}

class _AppointmentsTab extends StatelessWidget {
  const _AppointmentsTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundPrimary,
      appBar: AppBar(
        title: Text(
          'home.bottomNav.appointments'.tr(),
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s18,
            color: ColorManager.onPrimary,
          ),
        ),
        backgroundColor: ColorManager.primary,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Appointments page - Coming Soon',
          style: TextStyleManager.getRegularStyle(
            fontSize: FontSize.s16,
            color: ColorManager.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _ArticlesTab extends StatelessWidget {
  const _ArticlesTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundPrimary,
      appBar: AppBar(
        title: Text(
          'home.bottomNav.articles'.tr(),
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s18,
            color: ColorManager.onPrimary,
          ),
        ),
        backgroundColor: ColorManager.primary,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Articles page - Coming Soon',
          style: TextStyleManager.getRegularStyle(
            fontSize: FontSize.s16,
            color: ColorManager.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundPrimary,
      appBar: AppBar(
        title: Text(
          'home.bottomNav.profile'.tr(),
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s18,
            color: ColorManager.onPrimary,
          ),
        ),
        backgroundColor: ColorManager.primary,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Profile page - Coming Soon',
          style: TextStyleManager.getRegularStyle(
            fontSize: FontSize.s16,
            color: ColorManager.textSecondary,
          ),
        ),
      ),
    );
  }
}
