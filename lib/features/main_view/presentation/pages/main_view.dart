import 'package:clinic/features/home/presentation/pages/home_view.dart';
import 'package:clinic/features/profile/presentation/pages/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../Medical_examination_time/presentation/views/MedicalExaminationTimeView.dart';
import '../../../booking/presentation/views/booking_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});
  static const routeName = 'MainView';

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller =
        PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style3, // Choose the style you like
      backgroundColor: Colors.white, // Customize the background color
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      MedicalExaminationTimeView(),
      const BookingView(),
      const ProfileView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.green,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.calendar_today),
        title: "Appointment",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.green,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.green,
      ),
    ];
  }
}
