import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repos.dart';
import '../model/patient_model.dart';

class FirebaseBookingRepo implements BookingRepo {
  @override
  Future<Either<Failure, PatientModel>> addBooking(
      {required String name,
      required String address,
      required String phone,
      required String imageOne,
      required String imageTwo,
      required String imageThree,
      required DateTime dateDay,
      required List<DateTime> dateTime,
      required String age,
      required String note}) async {
    try {
      final String authId = FirebaseAuth.instance.currentUser!.uid;
      final PatientModel patient = PatientModel(
          name: name,
          address: address,
          phone: phone,
          imageOne: imageOne,
          imageThree: imageThree,
          imageTwo: imageTwo,
          age: age,
          dateDay: dateDay,
          dateTime: dateTime,
          note: note,
          id: authId);
      await FirebaseFirestore.instance
          .collection("patient")
          .doc(authId)
          .set(patient.toJson());
      return right(patient);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      print(
        'Exception in FirebaseBookingRepo.addBooking: ${e.toString()}',
      );
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة أخرى.',
        ),
      );
    }
  }
}
