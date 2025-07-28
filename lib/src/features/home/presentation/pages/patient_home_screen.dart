import 'package:clinic/src/core/res/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../data/models/doctor_work_model.dart';
import '../../data/models/article_model.dart';
import '../../data/mock_data_provider.dart';
import '../widgets/doctor_work_carousel.dart';
import '../widgets/article_card.dart';
import '../widgets/articles_section.dart';
import '../widgets/book_appointment_section.dart';
import '../widgets/home_app_bar.dart';
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
    final doctorWorks = MockDataProvider.getDoctorWorks();
    final articles = MockDataProvider.getArticles();

    return Scaffold(
      backgroundColor: ColorManager.backgroundPrimary,
      body: CustomScrollView(
        slivers: [
          // App Bar
          HomeAppBar(
            userName: 'أحمد محمد', // This should come from user data
            onNotificationTap: () {
              // Handle notification tap
            },
          ),
          // Content
          SliverPadding(
            padding: EdgeInsets.only(top: 24.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Doctor Work Carousel
                DoctorWorkCarousel(
                  doctorWorks: doctorWorks,
                  onViewAll: () {
                    // Navigate to doctor works page
                  },
                ),
                SizedBox(height: 32.h),
                // Book Appointment CTA
                BookAppointmentSection(
                  onBookAppointment: () {
                    // Navigate to appointment booking
                  },
                ),
                SizedBox(height: 32.h),
                // Articles Section
                ArticlesSection(
                  articles: articles,
                  onViewAll: () {
                    // Navigate to articles page
                  },
                  onArticleTap: (article) {
                    // Navigate to article details
                  },
                ),
                SizedBox(height: 24.h),
              ]),
            ),
          ),
        ],
      ),
    );
  }

}

// Enhanced Sliver Components for better performance and modularity
class _DoctorWorksSliver extends StatelessWidget {
  final List<DoctorWorkModel> doctorWorks;
  final VoidCallback? onViewAll;

  const _DoctorWorksSliver({
    required this.doctorWorks,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: DoctorWorkCarousel(
        doctorWorks: doctorWorks,
        onViewAll: onViewAll,
      ),
    );
  }
}

class _BookAppointmentSliver extends StatelessWidget {
  final VoidCallback? onBookAppointment;

  const _BookAppointmentSliver({
    this.onBookAppointment,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BookAppointmentSection(
        onBookAppointment: onBookAppointment,
      ),
    );
  }
}

class _ArticlesSliver extends StatelessWidget {
  final List<ArticleModel> articles;
  final VoidCallback? onViewAll;
  final Function(ArticleModel)? onArticleTap;

  const _ArticlesSliver({
    required this.articles,
    this.onViewAll,
    this.onArticleTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ArticlesSection(
        articles: articles,
        onViewAll: onViewAll,
        onArticleTap: onArticleTap,
      ),
    );
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
