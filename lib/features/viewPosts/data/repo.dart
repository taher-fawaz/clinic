import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/repo.dart';

class  FirebasePostRepo implements PostsRepo{


  @override
  Future<List<String>> getPostsFromFirestore() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('posts')
          .doc("post")
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return List<String>.from(data['posts'] ?? []);
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching posts: ${e.toString()}");
      return [];
    }
  }
}