import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminUtils {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Check if the current user is an admin
  static Future<bool> isCurrentUserAdmin() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;

      final doc = await _firestore.collection('users').doc(user.uid).get();
      return doc.exists ? (doc.data()?['isAdmin'] ?? false) : false;
    } catch (e) {
      return false;
    }
  }

  /// Set a user as admin (for development/testing purposes)
  /// In production, this should be done through admin panel or backend
  static Future<bool> setUserAsAdmin(String userId, bool isAdmin) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'isAdmin': isAdmin,
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get current user's admin status
  static Future<bool> getCurrentUserAdminStatus() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return doc.data()?['isAdmin'] ?? false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Make current user admin (for testing purposes)
  /// Remove this in production
  static Future<bool> makeCurrentUserAdmin() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;

      await _firestore.collection('users').doc(user.uid).set({
        'name': user.displayName ?? 'Admin User',
        'email': user.email ?? '',
        'uId': user.uid,
        'isAdmin': true,
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      return false;
    }
  }
}
