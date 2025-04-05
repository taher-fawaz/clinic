
import 'package:clinic/core/errors/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/helper_functions/build_error_bar.dart';
import '../../booking/data/model/patient_model.dart';
import '../domain/repo.dart';

class FirebaseAcceptOrCancelReservationRepo implements AcceptOrCancelReservationRepo{


  @override
  Future<Either<Failure, List<PatientModel>>> getAllPatients() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore.collection('patient').get();
      final patients = querySnapshot.docs.map((doc) {
        return PatientModel.fromJson(doc.data());
      }).toList();
      return right(patients);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      print(
        'Exception in FirebaseAcceptOr Cancel Reservation Repo.get all patients: ${e.toString()}',
      );
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة أخرى.',
        ),
      );
    }
  }

  @override
  Future<void> deletePatientDocument(String reservationId) async {
    try {
      await FirebaseFirestore.instance
          .collection("patient")
          .doc(reservationId)
          .delete();
      print("Document successfully deleted!");
    } catch (e) {
      print("Error deleting document: $e");
    }
  }

  @override
  Future<void> acceptOrCancelReservation( bool isAccepted,context, String userId, ) async {
    try {
      await FirebaseFirestore.instance
          .collection('reservations') // Changed to a meaningful collection name
          .doc(userId)
          .set({'isAccepted': isAccepted}, SetOptions(merge: true)); // Prevents overwriting existing data
      showBar(context, isAccepted ? "تم قبول الحجز بنجاح" : "تم إلغاء الحجز بنجاح");
    } catch (e) {
      showBar(context, "حدث خطأ: ${e.toString()}");
      print("Error: ${e.toString()}");
    }
  }
}
