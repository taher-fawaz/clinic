import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinic/features/home/domain/entities/offer_entity.dart';

class OfferModel extends OfferEntity {
  OfferModel({
    required String id,
    required String title,
    required String imageUrl,
    required DateTime validUntil,
    String description = '',
    double discountPercentage = 0,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          validUntil: validUntil,
          description: description,
          discountPercentage: discountPercentage,
        );

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      validUntil: json['validUntil'] != null
          ? (json['validUntil'] as Timestamp).toDate()
          : DateTime.now().add(const Duration(days: 30)),
      description: json['description'] ?? '',
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'validUntil': Timestamp.fromDate(validUntil),
      'description': description,
      'discountPercentage': discountPercentage,
    };
  }

  // Firebase specific methods
  factory OfferModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OfferModel.fromJson({
      ...data,
      'id': doc.id,
    });
  }

  Map<String, dynamic> toFirestore() {
    return toJson();
  }

  factory OfferModel.fromEntity(OfferEntity entity) {
    return OfferModel(
      id: entity.id,
      title: entity.title,
      imageUrl: entity.imageUrl,
      validUntil: entity.validUntil,
      description: entity.description,
      discountPercentage: entity.discountPercentage,
    );
  }
}
