import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/user_model.dart';

class FirebaseProfileRepository implements ProfileRepository {
  final FirebaseFirestore firestore;

  FirebaseProfileRepository({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<UserEntity> getUserProfile(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (!doc.exists) {
      throw Exception('User not found');
    }
    return UserModel.fromMap(doc.data()!..['uid'] = doc.id);
  }
}
