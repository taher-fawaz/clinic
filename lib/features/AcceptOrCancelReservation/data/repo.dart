
import 'package:clinic/core/errors/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/helper_functions/build_error_bar.dart';
import '../../booking/data/model/patient_model.dart';
import '../domain/repo.dart';

class FirebaseAcceptOrCancelReservationRepo extends AcceptOrCancelReservationRepo{
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
  Future<void> deletePatientDocument(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection("patient")
          .doc(userId)
          .delete();
      print("Document successfully deleted!");
    } catch (e) {
      print("Error deleting document: $e");
    }
  }
  @override
  Future<void> acceptOrCancelReservation(bool acceptOrDelete,context,String userId) async {

    try {
      await FirebaseFirestore.instance.collection('acceptOrCancelReservation')
          .doc(userId)
          .set({
        'acceptOrDelete': acceptOrDelete,

      });
      showBar(context, "تم حفظ الوقت بنجاح");
    }catch(e){
      showBar(context, "حدث خطأ${e.toString()}");
    }
  }





}
