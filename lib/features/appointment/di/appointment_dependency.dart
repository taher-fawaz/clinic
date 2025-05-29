import 'package:clinic/core/services/get_it_service.dart';
import 'package:clinic/features/admin/data/repositories/firebase_availability_repository.dart';
import 'package:clinic/features/appointment/domain/repos/appointment_repo.dart';
import 'package:clinic/features/appointment/presentation/cubits/appointment_cubit.dart';
import 'package:get_it/get_it.dart';

void setupAppointmentDependencies() {
  // Cubits
  if (!getIt.isRegistered<AppointmentCubit>()) {
    getIt.registerFactory<AppointmentCubit>(
      () => AppointmentCubit(
        getIt<AppointmentRepo>(),
        getIt<FirebaseAvailabilityRepository>(),
      ),
    );
  }
}
