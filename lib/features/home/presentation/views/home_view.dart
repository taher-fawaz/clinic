import 'package:clinic/core/utils/app_colors.dart';
import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';
import 'package:clinic/features/home/presentation/widgets/article_card.dart.dart';
import 'package:flutter/material.dart';

import '../widgets/next_appointment_card.dart.dart';
import '../widgets/offer_card.dart.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual data fetching logic
    final List<AppointmentEntity> appointments = [];
    final List<Map<String, dynamic>> articles = [];
    final List<Map<String, dynamic>> offers = [];

    AppointmentEntity? lastAppointment = appointments.isNotEmpty ? appointments.last : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Next Appointment Section
              const Text(
                'Your Last Appointment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              lastAppointment != null
                  ? NextAppointmentCard(appointment: lastAppointment)
                  : const Text('No appointments found.'),

              const SizedBox(height: 24),

              // Articles Section
              const Text(
                'Dental Health Articles',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              articles.isNotEmpty
                  ? SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return ArticleCard(
                            title: articles[index]['title'] as String,
                            imageUrl: articles[index]['image'] as String,
                            description: articles[index]['description'] as String,
                          );
                        },
                      ),
                    )
                  : const Text('No articles available.'),

              const SizedBox(height: 24),

              // Offers Section
              const Text(
                'Special Offers',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              offers.isNotEmpty
                  ? SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: offers.length,
                        itemBuilder: (context, index) {
                          return OfferCard(
                            title: offers[index]['title'] as String,
                            imageUrl: offers[index]['image'] as String,
                            validUntil: offers[index]['validUntil'] as DateTime,
                          );
                        },
                      ),
                    )
                  : const Text('No offers available.'),
            ],
          ),
        ),
      ),
    );
  }
}
