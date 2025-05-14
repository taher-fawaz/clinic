import 'package:clinic/core/services/get_it_service.dart';
import 'package:clinic/features/profile/data/repositories/firebase_profile_repository.dart';
import 'package:clinic/features/profile/domain/repositories/profile_repository.dart';
import 'package:clinic/features/profile/domain/usecases/get_user_profile.dart';
import 'package:clinic/features/profile/presentation/bloc/profile_bloc.dart';

void setupProfileDependencies() {
  // Register repository
  if (!getIt.isRegistered<ProfileRepository>()) {
    getIt.registerLazySingleton<ProfileRepository>(
        () => FirebaseProfileRepository());
  }

  // Register service
  if (!getIt.isRegistered<GetUserProfile>()) {
    getIt.registerLazySingleton<GetUserProfile>(
        () => GetUserProfile(getIt<ProfileRepository>()));
  }

  // Register controller
  if (!getIt.isRegistered<ProfileBloc>()) {
    getIt.registerFactory<ProfileBloc>(
        () => ProfileBloc(getUserProfile: getIt<GetUserProfile>()));
  }
}
