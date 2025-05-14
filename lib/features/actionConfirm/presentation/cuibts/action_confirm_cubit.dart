import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repo.dart';

part 'action_confirm_state.dart';

class ActionConfirmCubit extends Cubit<ActionConfirmState> {
  FirebaseActionConfirmRepo firebaseActionConfirmRepo;
  ActionConfirmCubit(this.firebaseActionConfirmRepo) : super(ActionConfirmInitial());

  void getActionConfirm() async {
    emit(ActionConfirmLoading());
    try {
      final isConfirmed = await firebaseActionConfirmRepo.getActionConfirm();
      emit(ActionConfirmSuccess( isConfirmed!));
    } catch (e) {
      emit(ActionConfirmFailure( message: e.toString()));

    }
  }
}
