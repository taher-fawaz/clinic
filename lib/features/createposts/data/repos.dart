import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/repos.dart';

class FirebasePostsRepo implements PostRepo{


@override

Future<void> savePostsToFirestore(List<String> posts) async {
  try {
    await FirebaseFirestore.instance.collection('posts').doc("post").set({
      'posts': posts,
    });
  } catch (e) {
    print("Error saving posts: ${e.toString()}");
  }
}
}