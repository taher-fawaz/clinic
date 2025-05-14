abstract class PostsRepo{
  Future<List<String>> getPostsFromFirestore();
}