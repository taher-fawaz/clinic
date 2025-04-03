import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/repo.dart';

class FirebaseActionConfirmRepo extends ActionConfirmRepo{
  Future<bool> getActionConfirm() async {
    final user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('acceptOrCancelReservation')
        .doc(user?.uid)  // 🔹 Fetch the document using the authenticated user ID
        .get();

    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('acceptOrDelete')) {
        return data['acceptOrDelete'] as bool;
      }}
    return false;
  }
}