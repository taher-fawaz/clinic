import 'package:clinic/src/core/res/app_res.dart';
import 'package:clinic/src/features/appointment/presentation/screens/appointment_status_screen.dart';
import 'package:clinic/src/features/appointment/presentation/screens/appointment_history_screen.dart';
import 'package:clinic/src/features/appointment/presentation/screens/book_appointment_screen.dart';
import 'package:clinic/src/features/home/presentation/widgets/book_appointment_section.dart';
import 'package:clinic/src/features/patient_medical_record/presentation/screens/patient_medical_record_screen.dart';
import 'package:clinic/src/features/profile/presentation/pages/patient_profile_screen.dart';
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
      const PatientMedicalRecordScreen(),
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
        inactiveIcon: const Icon(Icons.medical_information_outlined),
        icon: const Icon(Icons.medical_information),
        title: 'medicalRecord.title'.tr(),
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
                // Book Appointment CTA - Removed, now handled in appointments tab
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appointment Status Section
            BookAppointmentSection(
              onBookAppointment: () {
                // Navigate to appointment booking
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookAppointmentScreen(
                      doctorId: '', // Pass the selected doctor ID here
                      specialty: '', // Pass the selected specialty here
                    ),
                  ),
                );
              },
            ),
            _buildAppointmentStatusSection(context),
            SizedBox(height: 24.h),
            // Appointment History Section
            _buildAppointmentHistorySection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentStatusSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.shadowColor,
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'appointment.status.title'.tr(),
                style: TextStyleManager.getSemiBoldStyle(
                  fontSize: FontSize.s18,
                  color: ColorManager.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppointmentStatusScreen(),
                    ),
                  );
                },
                child: Text(
                  'common.viewAll'.tr(),
                  style: TextStyleManager.getMediumStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Mock upcoming appointment
          _buildAppointmentCard(
            doctorName: 'د. أحمد محمد',
            specialty: 'طب الأسنان العام',
            date: 'الغد، 15 ديسمبر',
            time: '10:00 - 10:30',
            status: 'confirmed',
          ),
          SizedBox(height: 12.h),
          _buildAppointmentCard(
            doctorName: 'د. فاطمة علي',
            specialty: 'تقويم الأسنان',
            date: 'الأحد، 17 ديسمبر',
            time: '14:00 - 14:30',
            status: 'pending',
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentHistorySection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.shadowColor,
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'appointment.history.title'.tr(),
                style: TextStyleManager.getSemiBoldStyle(
                  fontSize: FontSize.s18,
                  color: ColorManager.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppointmentHistoryScreen(),
                    ),
                  );
                },
                child: Text(
                  'common.viewAll'.tr(),
                  style: TextStyleManager.getMediumStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Mock past appointment
          _buildAppointmentCard(
            doctorName: 'د. محمد سالم',
            specialty: 'جراحة الفم والأسنان',
            date: '10 ديسمبر، 2023',
            time: '16:00 - 16:30',
            status: 'completed',
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard({
    required String doctorName,
    required String specialty,
    required String date,
    required String time,
    required String status,
  }) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case 'confirmed':
        statusColor = ColorManager.success;
        statusText = 'appointment.confirmed'.tr();
        statusIcon = Icons.check_circle;
        break;
      case 'pending':
        statusColor = ColorManager.warning;
        statusText = 'appointment.pending'.tr();
        statusIcon = Icons.schedule;
        break;
      case 'completed':
        statusColor = ColorManager.primary;
        statusText = 'appointment.completed'.tr();
        statusIcon = Icons.done_all;
        break;
      default:
        statusColor = ColorManager.error;
        statusText = 'appointment.cancelled'.tr();
        statusIcon = Icons.cancel;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.backgroundSecondary,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: TextStyleManager.getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      specialty,
                      style: TextStyleManager.getRegularStyle(
                        fontSize: FontSize.s14,
                        color: ColorManager.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      size: 14.sp,
                      color: statusColor,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      statusText,
                      style: TextStyleManager.getRegularStyle(
                        fontSize: FontSize.s12,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16.sp,
                color: ColorManager.textSecondary,
              ),
              SizedBox(width: 8.w),
              Text(
                date,
                style: TextStyleManager.getRegularStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.textSecondary,
                ),
              ),
              SizedBox(width: 16.w),
              Icon(
                Icons.access_time,
                size: 16.sp,
                color: ColorManager.textSecondary,
              ),
              SizedBox(width: 8.w),
              Text(
                time,
                style: TextStyleManager.getRegularStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
          ),
        ],
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
      body:PatientProfileScreen()
    );
  }
}
