import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinic/features/home/domain/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  ArticleModel({
    required String id,
    required String title,
    required String imageUrl,
    required String description,
    required DateTime publishDate,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          description: description,
          publishDate: publishDate,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      publishDate: json['publishDate'] != null
          ? (json['publishDate'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'publishDate': Timestamp.fromDate(publishDate),
    };
  }
}
