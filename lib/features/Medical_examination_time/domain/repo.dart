abstract class MedicalExaminationTimeRepo{
  saveTasks(List<String> tasksTime,context,DateTime selectedDate);
  Future<void> deletePastDays(context);
}