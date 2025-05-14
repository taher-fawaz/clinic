import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../booking/data/model/patient_model.dart';

abstract class AcceptOrCancelReservationRepo{
  Future<Either<Failure, List<PatientModel>>> getAllPatients();
  Future<void> deletePatientDocument(String userId);
  Future<void> acceptOrCancelReservation(bool acceptOrDelete,context,String userId);

  }