import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic/features/home/domain/entities/offer_entity.dart';
import 'package:clinic/features/admin/data/repositories/firebase_offer_repository.dart';
import 'dart:async';

// States
abstract class AdminOffersState {}

class AdminOffersInitial extends AdminOffersState {}

class AdminOffersLoading extends AdminOffersState {}

class AdminOffersLoaded extends AdminOffersState {
  final List<OfferEntity> offers;
  AdminOffersLoaded(this.offers);
}

class AdminOffersError extends AdminOffersState {
  final String message;
  AdminOffersError(this.message);
}

class AdminOffersOperationSuccess extends AdminOffersState {
  final String message;
  AdminOffersOperationSuccess(this.message);
}

// Events
abstract class AdminOffersEvent {}

class LoadOffers extends AdminOffersEvent {}

class AddOffer extends AdminOffersEvent {
  final OfferEntity offer;
  AddOffer(this.offer);
}

class UpdateOffer extends AdminOffersEvent {
  final OfferEntity offer;
  UpdateOffer(this.offer);
}

class DeleteOffer extends AdminOffersEvent {
  final String offerId;
  DeleteOffer(this.offerId);
}

// Cubit
class AdminOffersCubit extends Cubit<AdminOffersState> {
  final FirebaseOfferRepository _repository;
  StreamSubscription<List<OfferEntity>>? _offersSubscription;

  AdminOffersCubit(this._repository) : super(AdminOffersInitial());

  void loadOffers() {
    emit(AdminOffersLoading());

    _offersSubscription?.cancel();
    _offersSubscription = _repository.getOffers().listen(
      (offers) {
        emit(AdminOffersLoaded(offers));
      },
      onError: (error) {
        emit(AdminOffersError('Failed to load offers: $error'));
      },
    );
  }

  Future<void> addOffer(OfferEntity offer) async {
    try {
      emit(AdminOffersLoading());
      await _repository.addOffer(offer);
      emit(AdminOffersOperationSuccess('Offer added successfully'));
    } catch (e) {
      emit(AdminOffersError('Failed to add offer: $e'));
    }
  }

  Future<void> updateOffer(OfferEntity offer) async {
    try {
      emit(AdminOffersLoading());
      await _repository.updateOffer(offer);
      emit(AdminOffersOperationSuccess('Offer updated successfully'));
    } catch (e) {
      emit(AdminOffersError('Failed to update offer: $e'));
    }
  }

  Future<void> deleteOffer(String offerId) async {
    try {
      emit(AdminOffersLoading());
      await _repository.deleteOffer(offerId);
      emit(AdminOffersOperationSuccess('Offer deleted successfully'));
    } catch (e) {
      emit(AdminOffersError('Failed to delete offer: $e'));
    }
  }

  @override
  Future<void> close() {
    _offersSubscription?.cancel();
    return super.close();
  }
}
