import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinic/features/home/domain/entities/article_entity.dart';
import 'package:clinic/features/home/data/models/article_model.dart';

class FirebaseArticleRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'articles';

  // Get all articles
  Stream<List<ArticleEntity>> getArticles() {
    return _firestore
        .collection(_collection)
        .orderBy('publishDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ArticleModel.fromFirestore(doc);
      }).toList();
    });
  }

  // Add new article
  Future<void> addArticle(ArticleEntity article) async {
    try {
      final articleModel = ArticleModel.fromEntity(article);
      await _firestore
          .collection(_collection)
          .doc(article.id)
          .set(articleModel.toFirestore());
    } catch (e) {
      throw Exception('Failed to add article: $e');
    }
  }

  // Update existing article
  Future<void> updateArticle(ArticleEntity article) async {
    try {
      final articleModel = ArticleModel.fromEntity(article);
      await _firestore
          .collection(_collection)
          .doc(article.id)
          .update(articleModel.toFirestore());
    } catch (e) {
      throw Exception('Failed to update article: $e');
    }
  }

  // Delete article
  Future<void> deleteArticle(String articleId) async {
    try {
      await _firestore.collection(_collection).doc(articleId).delete();
    } catch (e) {
      throw Exception('Failed to delete article: $e');
    }
  }

  // Get single article by ID
  Future<ArticleEntity?> getArticleById(String articleId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(articleId).get();
      if (doc.exists) {
        return ArticleModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get article: $e');
    }
  }
}
