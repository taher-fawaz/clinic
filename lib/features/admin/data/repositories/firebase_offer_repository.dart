import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinic/features/home/domain/entities/offer_entity.dart';
import 'package:clinic/features/home/data/models/offer_model.dart';

class FirebaseOfferRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'offers';

  // Get all offers
  Stream<List<OfferEntity>> getOffers() {
    return _firestore
        .collection(_collection)
        .orderBy('validUntil', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return OfferModel.fromFirestore(doc);
      }).toList();
    });
  }

  // Add new offer
  Future<void> addOffer(OfferEntity offer) async {
    try {
      final offerModel = OfferModel.fromEntity(offer);
      await _firestore
          .collection(_collection)
          .doc(offer.id)
          .set(offerModel.toFirestore());
    } catch (e) {
      throw Exception('Failed to add offer: $e');
    }
  }

  // Update existing offer
  Future<void> updateOffer(OfferEntity offer) async {
    try {
      final offerModel = OfferModel.fromEntity(offer);
      await _firestore
          .collection(_collection)
          .doc(offer.id)
          .update(offerModel.toFirestore());
    } catch (e) {
      throw Exception('Failed to update offer: $e');
    }
  }

  // Delete offer
  Future<void> deleteOffer(String offerId) async {
    try {
      await _firestore.collection(_collection).doc(offerId).delete();
    } catch (e) {
      throw Exception('Failed to delete offer: $e');
    }
  }

  // Get single offer by ID
  Future<OfferEntity?> getOfferById(String offerId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(offerId).get();
      if (doc.exists) {
        return OfferModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get offer: $e');
    }
  }

  // Get active offers (not expired)
  Stream<List<OfferEntity>> getActiveOffers() {
    return _firestore
        .collection(_collection)
        .where('validUntil', isGreaterThan: Timestamp.now())
        .orderBy('validUntil', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return OfferModel.fromFirestore(doc);
      }).toList();
    });
  }
}
