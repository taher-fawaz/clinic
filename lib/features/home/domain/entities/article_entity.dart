class ArticleEntity {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final DateTime publishDate;

  ArticleEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.publishDate,
  });
}
