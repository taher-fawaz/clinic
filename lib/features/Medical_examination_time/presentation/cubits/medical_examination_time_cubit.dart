import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/repo/medical_examonation_time_repo.dart';

part 'medical_examination_time_state.dart';

class MedicalExaminationTimeCubit extends Cubit<MedicalExaminationTimeState> {

  MedicalExaminationTimeCubit(this.firebaseMedicalExaminationTimeRepo)  : selectedDate = DateTime.now(), super(MedicalExaminationTimeInitial());
  FirebaseMedicalExaminationTimeRepo firebaseMedicalExaminationTimeRepo;
  List<TimeOfDay> selectedTimes = List.generate(10, (index) => TimeOfDay.now());
  List<bool> chooseTIME = List.generate(10, (index) => true);
  DateTime selectedDate;

  Future<void> selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTimes[index],
    );
    if (picked != null) {
        selectedTimes[index] = picked;
        chooseTIME[index] =false;
      emit(MedicalExaminationTimeUpdated(selectedTimes, chooseTIME));
    }
  }

  Future<void> saveTime(context) async {
    emit(MedicalExaminationTimeLoading());
    try{
      List<String> formattedTimes = selectedTimes.asMap().entries.map((entry) {
        int index = entry.key;
        TimeOfDay time = entry.value;

        return chooseTIME[index] ? "" : time.format(context); // Save empty string if not chosen
      }).toList();
      firebaseMedicalExaminationTimeRepo.saveTasks(formattedTimes, context, selectedDate);
      emit(MedicalExaminationTimeSuccess());
    }catch(e){
      emit(MedicalExaminationTimeFailure("Failed to save times: $e"));
    }
    }
}
