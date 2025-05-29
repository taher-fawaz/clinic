import 'package:flutter/material.dart';
import 'package:clinic/core/utils/app_colors.dart';
import '../widgets/admin_articles_tab.dart';
import '../widgets/admin_offers_tab.dart';
import '../widgets/admin_appointments_tab.dart';
import '../widgets/admin_availability_tab.dart';

class AdminView extends StatelessWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Panel'),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: AppColors.secondaryColor,
            tabs: [
              Tab(
                icon: Icon(Icons.article),
                text: 'Articles',
              ),
              Tab(
                icon: Icon(Icons.local_offer),
                text: 'Offers',
              ),
              Tab(
                icon: Icon(Icons.calendar_today),
                text: 'Appointments',
              ),
              Tab(
                icon: Icon(Icons.schedule),
                text: 'Availability',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AdminArticlesTab(),
            AdminOffersTab(),
            AdminAppointmentsTab(),
            AdminAvailabilityTab(),
          ],
        ),
      ),
    );
  }
}
