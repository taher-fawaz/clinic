import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';
import 'package:clinic/features/home/domain/entities/article_entity.dart';
import 'package:clinic/features/home/domain/entities/offer_entity.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final List<AppointmentEntity> appointments;
  final List<ArticleEntity> articles;
  final List<OfferEntity> offers;
  final String? errorMessage;

  const HomeState({
    this.isLoading = false,
    this.appointments = const [],
    this.articles = const [],
    this.offers = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    bool? isLoading,
    List<AppointmentEntity>? appointments,
    List<ArticleEntity>? articles,
    List<OfferEntity>? offers,
    String? errorMessage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      appointments: appointments ?? this.appointments,
      articles: articles ?? this.articles,
      offers: offers ?? this.offers,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        appointments,
        articles,
        offers,
        errorMessage,
      ];
}
