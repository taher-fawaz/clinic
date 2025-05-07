import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:clinic/core/errors/failures.dart';

abstract class AppointmentRepo {
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments(
      String patientId);
  Future<Either<Failure, AppointmentEntity>> createAppointment(
      AppointmentEntity appointment);
  Future<Either<Failure, AppointmentEntity>> updateAppointment(
      AppointmentEntity appointment);
  Future<Either<Failure, void>> cancelAppointment(String appointmentId);
}
