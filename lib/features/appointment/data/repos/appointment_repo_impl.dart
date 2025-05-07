import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinic/core/errors/exceptions.dart';
import 'package:clinic/core/errors/failures.dart';
import 'package:clinic/core/services/data_service.dart';
import 'package:clinic/features/appointment/data/models/appointment_model.dart';
import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';
import 'package:clinic/features/appointment/domain/repos/appointment_repo.dart';
import 'package:dartz/dartz.dart';
import 'dart:developer';

class AppointmentRepoImpl implements AppointmentRepo {
  final DatabaseService databaseService;

  AppointmentRepoImpl({required this.databaseService});

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments(
      String patientId) async {
    try {
      final result = await databaseService.getData(
        path: 'appointments',
        query: {
          'orderBy': 'appointmentDate',
          'descending': true,
        },
      );

      final appointments = (result as List)
          .map((appointment) => AppointmentModel.fromJson(appointment))
          .where((appointment) => appointment.patientId == patientId)
          .toList();

      return right(appointments);
    } catch (e) {
      log('Error in AppointmentRepoImpl.getAppointments: ${e.toString()}');
      return left(ServerFailure('Failed to load appointments'));
    }
  }

  @override
  Future<Either<Failure, AppointmentEntity>> createAppointment(
      AppointmentEntity appointment) async {
    try {
      final appointmentModel = AppointmentModel(
        id: FirebaseFirestore.instance.collection('appointments').doc().id,
        patientId: appointment.patientId,
        doctorId: appointment.doctorId,
        appointmentDate: appointment.appointmentDate,
        status: appointment.status,
        notes: appointment.notes,
      );

      await databaseService.addData(
        path: 'appointments',
        documentId: appointmentModel.id,
        data: appointmentModel.toJson(),
      );

      return right(appointmentModel);
    } catch (e) {
      log('Error in AppointmentRepoImpl.createAppointment: ${e.toString()}');
      return left(ServerFailure('Failed to create appointment'));
    }
  }

  @override
  Future<Either<Failure, AppointmentEntity>> updateAppointment(
      AppointmentEntity appointment) async {
    try {
      final appointmentModel = AppointmentModel(
        id: appointment.id,
        patientId: appointment.patientId,
        doctorId: appointment.doctorId,
        appointmentDate: appointment.appointmentDate,
        status: appointment.status,
        notes: appointment.notes,
      );

      await databaseService.addData(
        path: 'appointments',
        documentId: appointmentModel.id,
        data: appointmentModel.toJson(),
      );

      return right(appointmentModel);
    } catch (e) {
      log('Error in AppointmentRepoImpl.updateAppointment: ${e.toString()}');
      return left(ServerFailure('Failed to update appointment'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelAppointment(String appointmentId) async {
    try {
      // First get the appointment
      final appointmentData = await databaseService.getData(
        path: 'appointments',
        docuementId: appointmentId,
      );

      if (appointmentData == null) {
        return left(ServerFailure('Appointment not found'));
      }

      final appointment = AppointmentModel.fromJson(appointmentData);

      // Update the status to cancelled
      final updatedAppointment = AppointmentModel(
        id: appointment.id,
        patientId: appointment.patientId,
        doctorId: appointment.doctorId,
        appointmentDate: appointment.appointmentDate,
        status: 'cancelled',
        notes: appointment.notes,
      );

      await databaseService.addData(
        path: 'appointments',
        documentId: appointmentId,
        data: updatedAppointment.toJson(),
      );

      return right(null);
    } catch (e) {
      log('Error in AppointmentRepoImpl.cancelAppointment: ${e.toString()}');
      return left(ServerFailure('Failed to cancel appointment'));
    }
  }
}
