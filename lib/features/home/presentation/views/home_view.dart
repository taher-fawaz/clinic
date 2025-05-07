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
    // Dummy data for demonstration
    final nextAppointment = AppointmentEntity(
      id: '1',
      patientId: 'patient1',
      doctorId: 'doctor1',
      appointmentDate: DateTime.now().add(const Duration(days: 2)),
      status: 'scheduled',
      notes: 'Regular checkup',
    );

    final articles = [
      {
        'title': 'Maintaining Healthy Teeth',
        'image': 'assets/images/article1.png',
        'description': 'Tips for keeping your teeth healthy and strong.',
      },
      {
        'title': 'Benefits of Regular Dental Checkups',
        'image': 'assets/images/article2.png',
        'description': 'Why you should visit your dentist regularly.',
      },
    ];

    final offers = [
      {
        'title': '20% Off Teeth Whitening',
        'image': 'assets/images/offer1.png',
        'validUntil': DateTime.now().add(const Duration(days: 30)),
      },
      {
        'title': 'Free Dental Checkup',
        'image': 'assets/images/offer2.png',
        'validUntil': DateTime.now().add(const Duration(days: 15)),
      },
    ];

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
                'Your Next Appointment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              NextAppointmentCard(appointment: nextAppointment),

              const SizedBox(height: 24),

              // Articles Section
              const Text(
                'Dental Health Articles',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
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
              ),

              const SizedBox(height: 24),

              // Offers Section
              const Text(
                'Special Offers',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
