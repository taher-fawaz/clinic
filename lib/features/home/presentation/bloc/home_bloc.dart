import 'package:bloc/bloc.dart';
import 'package:clinic/features/home/domain/repos/home_repo.dart';
import 'package:clinic/features/home/presentation/bloc/home_event.dart';
import 'package:clinic/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepo homeRepo;

  HomeBloc({required this.homeRepo}) : super(const HomeState()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<RefreshHomeData>(_onRefreshHomeData);
  }

  Future<void> _onLoadHomeData(
      LoadHomeData event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final appointmentsResult =
          await homeRepo.getUserAppointments(event.userId);
      if (emit.isDone) return;

      await appointmentsResult.fold(
        (failure) async {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: failure.message,
          ));
        },
        (appointments) async {
          final articlesResult = await homeRepo.getArticles();
          if (emit.isDone) return;

          await articlesResult.fold(
            (failure) async {
              emit(state.copyWith(
                isLoading: false,
                appointments: appointments,
                errorMessage: failure.message,
              ));
            },
            (articles) async {
              final offersResult = await homeRepo.getOffers();
              if (emit.isDone) return;

              offersResult.fold(
                (failure) {
                  emit(state.copyWith(
                    isLoading: false,
                    appointments: appointments,
                    articles: articles,
                    errorMessage: failure.message,
                  ));
                },
                (offers) {
                  emit(state.copyWith(
                    isLoading: false,
                    appointments: appointments,
                    articles: articles,
                    offers: offers,
                  ));
                },
              );
            },
          );
        },
      );
    } catch (e) {
      if (emit.isDone) return;
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred: ${e.toString()}',
      ));
    }
  }

  Future<void> _onRefreshHomeData(
      RefreshHomeData event, Emitter<HomeState> emit) async {
    // Keep current data but start loading
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Reuse the load logic
    await _onLoadHomeData(LoadHomeData(userId: event.userId), emit);
  }
}
