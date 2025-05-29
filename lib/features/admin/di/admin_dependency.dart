import 'package:clinic/core/services/get_it_service.dart';
import 'package:clinic/features/admin/data/repositories/firebase_appointment_repository.dart';
import 'package:clinic/features/admin/data/repositories/firebase_article_repository.dart';
import 'package:clinic/features/admin/data/repositories/firebase_offer_repository.dart';
import 'package:clinic/features/admin/presentation/cubits/admin_appointments_cubit.dart';
import 'package:clinic/features/admin/presentation/cubits/admin_articles_cubit.dart';
import 'package:clinic/features/admin/presentation/cubits/admin_offers_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupAdminDependencies() {
  // Repositories
  if (!getIt.isRegistered<FirebaseAppointmentRepository>()) {
    getIt.registerSingleton<FirebaseAppointmentRepository>(
      FirebaseAppointmentRepository(),
    );
  }

  if (!getIt.isRegistered<FirebaseArticleRepository>()) {
    getIt.registerSingleton<FirebaseArticleRepository>(
      FirebaseArticleRepository(),
    );
  }

  if (!getIt.isRegistered<FirebaseOfferRepository>()) {
    getIt.registerSingleton<FirebaseOfferRepository>(
      FirebaseOfferRepository(),
    );
  }

  // Cubits
  if (!getIt.isRegistered<AdminAppointmentsCubit>()) {
    getIt.registerFactory<AdminAppointmentsCubit>(
      () => AdminAppointmentsCubit(
        getIt<FirebaseAppointmentRepository>(),
      ),
    );
  }

  if (!getIt.isRegistered<AdminArticlesCubit>()) {
    getIt.registerFactory<AdminArticlesCubit>(
      () => AdminArticlesCubit(
        getIt<FirebaseArticleRepository>(),
      ),
    );
  }

  if (!getIt.isRegistered<AdminOffersCubit>()) {
    getIt.registerFactory<AdminOffersCubit>(
      () => AdminOffersCubit(
        getIt<FirebaseOfferRepository>(),
      ),
    );
  }
}
