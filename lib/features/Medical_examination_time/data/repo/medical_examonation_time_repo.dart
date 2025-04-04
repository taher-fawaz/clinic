
import 'package:clinic/features/Medical_examination_time/domain/repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/helper_functions/build_error_bar.dart';

class FirebaseMedicalExaminationTimeRepo extends MedicalExaminationTimeRepo{

@override
  Future<void> saveTasks(List<String> tasksTime,context,DateTime selectedDate) async {

  DateTime now = selectedDate;
  String formattedDate = "${now.year}-${now.month}-${now.day}"; // Format: YYYY-MM-DD
try {
  await FirebaseFirestore.instance.collection('tasksByDate')
      .doc(formattedDate)
      .set({
    'date': formattedDate,
    'timestamp': now, // Store the exact time for reference
    'tasks': tasksTime,
  });
  showBar(context, "تم حفظ الوقت بنجاح");
}catch(e){
  showBar(context, "حدث خطأ${e.toString()}");
}
}

@override
Future<void> deletePastDays(context) async {
  try {
    DateTime now = DateTime.now();
    String todayFormatted = "${now.year}-${now.month}-${now.day}";

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('tasksByDate')
        .get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      String docId = doc.id;

      if (docId.compareTo(todayFormatted) < 0) {
        await FirebaseFirestore.instance.collection('tasksByDate').doc(docId).delete();
      }
    }
print( "تم حذف جميع الأيام الماضية بنجاح");
  } catch (e) {
    print( "حدث خطأ أثناء الحذف: ${e.toString()}");
  }
}
}