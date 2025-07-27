import 'package:clinic/core/services/data_service.dart';
import 'package:clinic/core/services/firebase_auth_service.dart';
import 'package:clinic/core/services/firestore_service.dart';
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

 
}
