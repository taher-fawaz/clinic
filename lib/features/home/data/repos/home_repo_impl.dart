import 'dart:developer';

import 'package:clinic/core/errors/failures.dart';
import 'package:clinic/core/services/data_service.dart';
import 'package:clinic/features/appointment/data/models/appointment_model.dart';
import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';
import 'package:clinic/features/home/data/models/article_model.dart';
import 'package:clinic/features/home/data/models/offer_model.dart';
import 'package:clinic/features/home/domain/entities/article_entity.dart';
import 'package:clinic/features/home/domain/entities/offer_entity.dart';
import 'package:clinic/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl implements HomeRepo {
  final DatabaseService databaseService;

  HomeRepoImpl({required this.databaseService});

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getUserAppointments(
      String userId) async {
    try {
      final result = await databaseService.getData(
        path: 'appointments',
        query: {
          'orderBy': 'appointmentDate',
          'descending': true,
        },
      );

      final appointments = (result as List)
          .map((appointment) => AppointmentModel.fromJson(appointment))
          .where((appointment) => appointment.patientId == userId)
          .toList();

      return right(appointments);
    } catch (e) {
      log('Error in HomeRepoImpl.getUserAppointments: ${e.toString()}');
      return left(ServerFailure('Failed to load appointments'));
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticles() async {
    try {
      final result = await databaseService.getData(
        path: 'articles',
        query: {
          'orderBy': 'publishDate',
          'descending': true,
          'limit': 10,
        },
      );

      final articles = (result as List)
          .map((article) => ArticleModel.fromJson(article))
          .toList();

      return right(articles);
    } catch (e) {
      log('Error in HomeRepoImpl.getArticles: ${e.toString()}');
      return left(ServerFailure('Failed to load articles'));
    }
  }

  @override
  Future<Either<Failure, List<OfferEntity>>> getOffers() async {
    try {
      final result = await databaseService.getData(
        path: 'offers',
        query: {
          'orderBy': 'validUntil',
          'descending': false,
        },
      );

      final offers =
          (result as List).map((offer) => OfferModel.fromJson(offer)).toList();

      return right(offers);
    } catch (e) {
      log('Error in HomeRepoImpl.getOffers: ${e.toString()}');
      return left(ServerFailure('Failed to load offers'));
    }
  }
}
