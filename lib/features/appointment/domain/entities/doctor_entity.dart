class DoctorEntity {
  final String id;
  final String name;
  final String specialization;
  final String imageUrl;
  final String bio;
  final double rating;
  final List<String> availableDays;

  DoctorEntity({
    required this.id,
    required this.name,
    required this.specialization,
    required this.imageUrl,
    required this.bio,
    required this.rating,
    required this.availableDays,
  });
}
