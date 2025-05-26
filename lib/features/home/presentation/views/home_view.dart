import 'package:clinic/core/utils/app_colors.dart';
import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';
import 'package:clinic/features/home/domain/entities/article_entity.dart';
import 'package:clinic/features/home/domain/entities/offer_entity.dart';
import 'package:clinic/features/home/presentation/bloc/home_bloc.dart';
import 'package:clinic/features/home/presentation/bloc/home_event.dart';
import 'package:clinic/features/home/presentation/bloc/home_state.dart';
import 'package:clinic/features/home/presentation/widgets/article_card.dart.dart';
import 'package:clinic/features/home/presentation/widgets/offer_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../widgets/next_appointment_card.dart.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<HomeBloc>()
        ..add(
          LoadHomeData(userId: FirebaseAuth.instance.currentUser?.uid ?? ''),
        ),
      child: const HomeViewContent(),
    );
  }
}

class HomeViewContent extends StatelessWidget {
  const HomeViewContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(
                    RefreshHomeData(
                        userId: FirebaseAuth.instance.currentUser?.uid ?? ''),
                  );
            },
            child: state.isLoading &&
                    state.appointments.isEmpty &&
                    state.articles.isEmpty &&
                    state.offers.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : _buildContent(context, state),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, HomeState state) {
    AppointmentEntity? lastAppointment =
        state.appointments.isNotEmpty ? state.appointments.last : null;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
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
            state.articles.isNotEmpty
                ? SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.articles.length,
                      itemBuilder: (context, index) {
                        final article = state.articles[index];
                        return ArticleCard(
                          title: article.title,
                          imageUrl: article.imageUrl,
                          description: article.description,
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
            state.offers.isNotEmpty
                ? SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.offers.length,
                      itemBuilder: (context, index) {
                        final offer = state.offers[index];
                        return OfferCard(
                          title: offer.title,
                          imageUrl: offer.imageUrl,
                          validUntil: offer.validUntil,
                        );
                      },
                    ),
                  )
                : const Text('No offers available.'),

            // Error message if any
            if (state.errorMessage != null) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.red.shade100,
                child: Text(
                  state.errorMessage!,
                  style: TextStyle(color: Colors.red.shade900),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
