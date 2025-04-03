import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../booking/data/model/patient_model.dart';
import '../../data/repo.dart';
part 'accept_or_cancel_reservation_state.dart';

class AcceptOrCancelReservationCubit extends Cubit<AcceptOrCancelReservationState> {
  final FirebaseAcceptOrCancelReservationRepo firebaseAcceptOrCancelReservationRepo;
  AcceptOrCancelReservationCubit(this.firebaseAcceptOrCancelReservationRepo)
      : super(AcceptOrCancelReservationInitial());
  Future<void> acceptOrCancelReservation() async {
    emit(AcceptOrCancelReservationLoading());
    var result = await firebaseAcceptOrCancelReservationRepo.getAllPatients();

    result.fold(
          (failure) => emit(AcceptOrCancelReservationFailure(message: failure.message)),
          (patient) => emit(AcceptOrCancelReservationSuccess(patient)),
    );
  }
Future<void>deletePatientDocument(userId)async{
    emit(DeletedPatientLoading());
    var result = await firebaseAcceptOrCancelReservationRepo.deletePatientDocument(userId);
    emit(DeletedPatientSuccess());
}

  Future<void> acceptOrCancelReservationAction(acceptOrDelete, context,String userId) async {
    await firebaseAcceptOrCancelReservationRepo.acceptOrCancelReservation(acceptOrDelete, context,userId);
  }

}
