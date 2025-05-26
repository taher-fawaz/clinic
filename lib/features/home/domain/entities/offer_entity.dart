class OfferEntity {
  final String id;
  final String title;
  final String imageUrl;
  final DateTime validUntil;
  final String description;
  final double discountPercentage;

  OfferEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.validUntil,
    this.description = '',
    this.discountPercentage = 0,
  });
}
