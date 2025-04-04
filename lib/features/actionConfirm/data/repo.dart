import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/repo.dart';

class FirebaseActionConfirmRepo extends ActionConfirmRepo{
  Future<bool?> getActionConfirm() async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('reservations') // 🔹 Ensure it matches the update function
          .doc(user?.uid)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data['isAccepted'] ?? false;
      }
    } catch (e) {
      print("Error fetching data: ${e.toString()}");
    }
    return null;
}}