part of 'medical_examination_time_cubit.dart';

@immutable
sealed class MedicalExaminationTimeState {}

final class MedicalExaminationTimeInitial extends MedicalExaminationTimeState {}
final class MedicalExaminationTimeLoading extends MedicalExaminationTimeState {}
final class MedicalExaminationTimeSuccess extends MedicalExaminationTimeState {}
final class MedicalExaminationTimeFailure extends MedicalExaminationTimeState {
  final String message;

  MedicalExaminationTimeFailure(this.message);
}

class MedicalExaminationTimeUpdated extends MedicalExaminationTimeState {
  final List<TimeOfDay> selectedTimes;
  final List<bool> chooseTIME;

  MedicalExaminationTimeUpdated(this.selectedTimes, this.chooseTIME);
}
final class DeletePastDaysLoading extends MedicalExaminationTimeState {}
final class DeletePastDaysSuccess extends MedicalExaminationTimeState {}
final class DeletePastDaysFailure extends MedicalExaminationTimeState {
  final String message;

  DeletePastDaysFailure(this.message);
}