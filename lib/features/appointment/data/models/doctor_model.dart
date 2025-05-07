import 'package:clinic/features/appointment/domain/entities/doctor_entity.dart';

class DoctorModel extends DoctorEntity {
  DoctorModel({
    required String id,
    required String name,
    required String specialization,
    required String imageUrl,
    required String bio,
    required double rating,
    required List<String> availableDays,
  }) : super(
          id: id,
          name: name,
          specialization: specialization,
          imageUrl: imageUrl,
          bio: bio,
          rating: rating,
          availableDays: availableDays,
        );

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      specialization: json['specialization'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      bio: json['bio'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      availableDays: List<String>.from(json['availableDays'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'imageUrl': imageUrl,
      'bio': bio,
      'rating': rating,
      'availableDays': availableDays,
    };
  }
}
