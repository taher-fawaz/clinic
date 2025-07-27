import 'package:equatable/equatable.dart';

class ArticleModel extends Equatable {
  final String id;
  final String title;
  final String shortDescription;
  final String content;
  final String thumbnailUrl;
  final String authorName;
  final String authorImageUrl;
  final DateTime publishedAt;
  final DateTime updatedAt;
  final List<String> tags;
  final int readTimeMinutes;
  final bool isFeatured;

  const ArticleModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.content,
    required this.thumbnailUrl,
    required this.authorName,
    required this.authorImageUrl,
    required this.publishedAt,
    required this.updatedAt,
    required this.tags,
    required this.readTimeMinutes,
    this.isFeatured = false,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] as String,
      title: json['title'] as String,
      shortDescription: json['shortDescription'] as String,
      content: json['content'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      authorName: json['authorName'] as String,
      authorImageUrl: json['authorImageUrl'] as String,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      tags: List<String>.from(json['tags'] as List),
      readTimeMinutes: json['readTimeMinutes'] as int,
      isFeatured: json['isFeatured'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'shortDescription': shortDescription,
      'content': content,
      'thumbnailUrl': thumbnailUrl,
      'authorName': authorName,
      'authorImageUrl': authorImageUrl,
      'publishedAt': publishedAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'tags': tags,
      'readTimeMinutes': readTimeMinutes,
      'isFeatured': isFeatured,
    };
  }

  ArticleModel copyWith({
    String? id,
    String? title,
    String? shortDescription,
    String? content,
    String? thumbnailUrl,
    String? authorName,
    String? authorImageUrl,
    DateTime? publishedAt,
    DateTime? updatedAt,
    List<String>? tags,
    int? readTimeMinutes,
    bool? isFeatured,
  }) {
    return ArticleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
      content: content ?? this.content,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      authorName: authorName ?? this.authorName,
      authorImageUrl: authorImageUrl ?? this.authorImageUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      readTimeMinutes: readTimeMinutes ?? this.readTimeMinutes,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        shortDescription,
        content,
        thumbnailUrl,
        authorName,
        authorImageUrl,
        publishedAt,
        updatedAt,
        tags,
        readTimeMinutes,
        isFeatured,
      ];
}