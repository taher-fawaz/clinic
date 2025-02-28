import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_view_event.dart';
part 'main_view_state.dart';

class MainViewBloc extends Bloc<MainViewEvent, MainViewState> {
  MainViewBloc() : super(MainViewInitial()) {
    on<MainViewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
