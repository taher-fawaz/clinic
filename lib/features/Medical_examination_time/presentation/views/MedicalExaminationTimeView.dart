import 'package:clinic/features/Medical_examination_time/presentation/views/widgets/MedicalExaminationTimeBlocConsumer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/repo/medical_examonation_time_repo.dart';
import '../cubits/medical_examination_time_cubit.dart';

class MedicalExaminationTimeView extends StatefulWidget {

  @override
  State<MedicalExaminationTimeView> createState() => _MedicalExaminationTimeViewState();
}

class _MedicalExaminationTimeViewState extends State<MedicalExaminationTimeView> {

  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTodayTasks();
  }

  void fetchTodayTasks() async {
    List<String> loadedTasks = await getTasksForToday();
    setState(() {
      tasks = loadedTasks;
    });
  }

  Future<List<String>> getTasksForToday() async {
    DateTime now = DateTime.now();
    String todayDate = "${now.year}-${now.month}-${now.day}";

    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('tasksByDate').doc(todayDate).get();

    if (doc.exists) {
      return List<String>.from(doc['tasks']);
    } else {
      print("❌ No tasks found for $todayDate");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicalExaminationTimeCubit(
        getIt.get<FirebaseMedicalExaminationTimeRepo>(),
      ),
        child: Scaffold(
          appBar: CustomBuildAppBar(context,
              title: "حجز الموعد", showBackButton: false),
          body:MedicalExaminationTimeBlocConsumer(),

          ),
        );
  }
}