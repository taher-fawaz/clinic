import 'package:clinic/core/services/data_service.dart';
import 'package:clinic/core/services/firebase_auth_service.dart';
import 'package:clinic/core/services/firestore_service.dart';
import 'package:clinic/features/auth/data/repos/auth_repo_impl.dart';
import 'package:clinic/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

import '../../features/AcceptOrCancelReservation/data/repo.dart';
import '../../features/Medical_examination_time/data/repo/medical_examonation_time_repo.dart';
import '../../features/actionConfirm/data/repo.dart';
import '../../features/booking/data/repos/repo.dart';

final getIt = GetIt.instance;

void setupGetit() {
  if (!getIt.isRegistered<FirebaseAuthService>()) {
    getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  }
  if (!getIt.isRegistered<DatabaseService>()) {
    getIt.registerSingleton<DatabaseService>(FireStoreService());
  }
  if (!getIt.isRegistered<AuthRepo>()) {
    getIt.registerSingleton<AuthRepo>(
      AuthRepoImpl(
        firebaseAuthService: getIt<FirebaseAuthService>(),
        databaseService: getIt<DatabaseService>(),
      ),
    );
  }
  if (!getIt.isRegistered<FirebaseBookingRepo>()) {
    getIt.registerLazySingleton<FirebaseBookingRepo>(
        () => FirebaseBookingRepo());
  }
  if (!getIt.isRegistered<FirebaseMedicalExaminationTimeRepo>()) {
    getIt.registerLazySingleton<FirebaseMedicalExaminationTimeRepo>(
            () => FirebaseMedicalExaminationTimeRepo()); // Ensure this is a valid implementation
  }
  if (!getIt.isRegistered<FirebaseAcceptOrCancelReservationRepo>()) {
    getIt.registerLazySingleton<FirebaseAcceptOrCancelReservationRepo>(
            () => FirebaseAcceptOrCancelReservationRepo()); // Ensure this is a valid implementation
  }
  if (!getIt.isRegistered<FirebaseActionConfirmRepo>()) {
    getIt.registerLazySingleton<FirebaseActionConfirmRepo>(
            () => FirebaseActionConfirmRepo()); // Ensure this is a valid implementation
  }
}
