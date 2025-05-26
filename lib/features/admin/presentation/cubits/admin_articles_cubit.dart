import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic/features/home/domain/entities/article_entity.dart';
import 'package:clinic/features/admin/data/repositories/firebase_article_repository.dart';
import 'dart:async';

// States
abstract class AdminArticlesState {}

class AdminArticlesInitial extends AdminArticlesState {}

class AdminArticlesLoading extends AdminArticlesState {}

class AdminArticlesLoaded extends AdminArticlesState {
  final List<ArticleEntity> articles;
  AdminArticlesLoaded(this.articles);
}

class AdminArticlesError extends AdminArticlesState {
  final String message;
  AdminArticlesError(this.message);
}

class AdminArticlesOperationSuccess extends AdminArticlesState {
  final String message;
  AdminArticlesOperationSuccess(this.message);
}

// Events
abstract class AdminArticlesEvent {}

class LoadArticles extends AdminArticlesEvent {}

class AddArticle extends AdminArticlesEvent {
  final ArticleEntity article;
  AddArticle(this.article);
}

class UpdateArticle extends AdminArticlesEvent {
  final ArticleEntity article;
  UpdateArticle(this.article);
}

class DeleteArticle extends AdminArticlesEvent {
  final String articleId;
  DeleteArticle(this.articleId);
}

// Cubit
class AdminArticlesCubit extends Cubit<AdminArticlesState> {
  final FirebaseArticleRepository _repository;
  StreamSubscription<List<ArticleEntity>>? _articlesSubscription;

  AdminArticlesCubit(this._repository) : super(AdminArticlesInitial());

  void loadArticles() {
    emit(AdminArticlesLoading());

    _articlesSubscription?.cancel();
    _articlesSubscription = _repository.getArticles().listen(
      (articles) {
        emit(AdminArticlesLoaded(articles));
      },
      onError: (error) {
        emit(AdminArticlesError('Failed to load articles: $error'));
      },
    );
  }

  Future<void> addArticle(ArticleEntity article) async {
    try {
      emit(AdminArticlesLoading());
      await _repository.addArticle(article);
      emit(AdminArticlesOperationSuccess('Article added successfully'));
    } catch (e) {
      emit(AdminArticlesError('Failed to add article: $e'));
    }
  }

  Future<void> updateArticle(ArticleEntity article) async {
    try {
      emit(AdminArticlesLoading());
      await _repository.updateArticle(article);
      emit(AdminArticlesOperationSuccess('Article updated successfully'));
    } catch (e) {
      emit(AdminArticlesError('Failed to update article: $e'));
    }
  }

  Future<void> deleteArticle(String articleId) async {
    try {
      emit(AdminArticlesLoading());
      await _repository.deleteArticle(articleId);
      emit(AdminArticlesOperationSuccess('Article deleted successfully'));
    } catch (e) {
      emit(AdminArticlesError('Failed to delete article: $e'));
    }
  }

  @override
  Future<void> close() {
    _articlesSubscription?.cancel();
    return super.close();
  }
}
