import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repos.dart';
import '../model/patient_model.dart';
import 'package:intl/intl.dart';


class FirebaseBookingRepo implements BookingRepo {
  @override
  Future<Either<Failure, PatientModel>> addBooking({
    required String selectPatient,
    required String name,
    required String address,
    required String phone,
    required String imageOne,
    required String imageTwo,
    required String imageThree,
    required DateTime dateDay,
    required String dateTime,
    required String age,
    required String note}) async {
    try {
      final String authId = FirebaseAuth.instance.currentUser!.uid;
      final PatientModel patientt = PatientModel(
          selectPatient:selectPatient,
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
          .set(patientt.toJson());
      return right(patientt);
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

  @override
  Future<List<DateTime>> getTimeForToday( context,DateTime dateNow) async {
    try {
      DateTime now =dateNow ;
       String todayDate = "${now.year}-${now.month}-${now.day}";

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('tasksByDate')
          .doc(todayDate.toString())
          .get();
      print("🔥 Firestore Data: ${doc.data()}");
      if (doc.exists && doc.data() != null) {
        List<dynamic> rawTasks = doc['tasks'];

        List<DateTime> tasks = [];

        for (var item in rawTasks) {
          if (item is Timestamp) {
            tasks.add(item.toDate());
          } else if (item is String && item.isNotEmpty) {
            try {
              // Attach today's date to the time string and parse
              String todayDateString = DateFormat('yyyy-MM-dd').format(now);
              DateTime parsedTime =
              DateFormat("yyyy-MM-dd h:mm a").parse("$todayDateString $item");
              tasks.add(parsedTime);
            } catch (e) {
              print("❌ Invalid date string: $item - ${e.toString()}");
            }
          } else {
            print("⚠️ Skipping invalid or empty task: $item");
          }
        }
        return tasks;
      } else {
        return [];
      }
    } catch (e) {
      print("❌ Error fetching tasks: ${e.toString()}");
      return []; // Ensure the function never returns void
    }
  }

}