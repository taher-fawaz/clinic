import 'package:clinic/core/errors/failures.dart';
import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';
import 'package:clinic/features/home/domain/entities/article_entity.dart';
import 'package:clinic/features/home/domain/entities/offer_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<AppointmentEntity>>> getUserAppointments(
      String userId);
  Future<Either<Failure, List<ArticleEntity>>> getArticles();
  Future<Either<Failure, List<OfferEntity>>> getOffers();
}
