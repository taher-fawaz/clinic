import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:clinic/core/utils/app_colors.dart';
import 'package:clinic/features/home/presentation/views/home_view.dart';
import 'package:clinic/features/appointment/presentation/views/appointment_view.dart';
import 'package:clinic/features/profile/presentation/views/profile_view.dart';
import 'package:clinic/features/admin/presentation/views/admin_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  static const routeName = 'MainView';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool isAdmin = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  Future<void> _checkUserRole() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          setState(() {
            isAdmin = doc.data()?['isAdmin'] ?? false;
            isLoading = false;
          });
        } else {
          setState(() {
            isAdmin = false;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isAdmin = false;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isAdmin = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    PersistentTabController _controller =
        PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style3,
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  List<Widget> _buildScreens() {
    List<Widget> screens = [
      const HomeView(),
      const AppointmentView(),
      const ProfileView(),
    ];

    if (isAdmin) {
      screens.insert(screens.length - 1, const AdminView());
    }

    return screens;
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    List<PersistentBottomNavBarItem> items = [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.calendar_today),
        title: "Appointment",
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];

    if (isAdmin) {
      items.add(
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.admin_panel_settings),
          title: "Admin",
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
      );
    }

    items.add(
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
    );

    return items;
  }
}
