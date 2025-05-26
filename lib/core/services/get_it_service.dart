import 'package:clinic/core/services/data_service.dart';
import 'package:clinic/core/services/firebase_auth_service.dart';
import 'package:clinic/core/services/firestore_service.dart';
import 'package:clinic/features/appointment/data/repos/appointment_repo_impl.dart';
import 'package:clinic/features/appointment/domain/repos/appointment_repo.dart';
import 'package:clinic/features/auth/data/repos/auth_repo_impl.dart';
import 'package:clinic/features/auth/domain/repos/auth_repo.dart';
import 'package:clinic/features/home/di/home_dependency.dart';
import 'package:clinic/features/profile/di/profile_dependency.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetit() {
  // Services
  if (!getIt.isRegistered<FirebaseAuthService>()) {
    getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  }
  if (!getIt.isRegistered<DatabaseService>()) {
    getIt.registerSingleton<DatabaseService>(FireStoreService());
  }

  // Repositories
  if (!getIt.isRegistered<AuthRepo>()) {
    getIt.registerSingleton<AuthRepo>(
      AuthRepoImpl(
        firebaseAuthService: getIt<FirebaseAuthService>(),
        databaseService: getIt<DatabaseService>(),
      ),
    );
  }

  // Appointment Repository
  if (!getIt.isRegistered<AppointmentRepo>()) {
    getIt.registerSingleton<AppointmentRepo>(
      AppointmentRepoImpl(
        databaseService: getIt<DatabaseService>(),
      ),
    );
  }

  // Setup feature dependencies
  setupProfileDependencies();
  setupHomeDependencies();
}
