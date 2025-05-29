import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinic/features/admin/data/models/availability_slot_model.dart';

class FirebaseAvailabilityRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'availability_slots';

  // Add a new availability slot
  Future<DocumentReference> addAvailabilitySlot(
      AvailabilitySlotModel slot) async {
    try {
      return await _firestore.collection(_collectionPath).add(slot.toJson());
    } catch (e) {
      // Log error or handle as needed
      print('Error adding availability slot: $e');
      rethrow;
    }
  }

  // Get all availability slots
  Stream<List<AvailabilitySlotModel>> getAvailabilitySlots() {
    return _firestore.collection(_collectionPath).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => AvailabilitySlotModel.fromSnapshot(doc))
          .toList();
    });
  }

  // Get available slots (not booked)
  Stream<List<AvailabilitySlotModel>> getAvailableSlots() {
    return _firestore
        .collection(_collectionPath)
        .where('isBooked', isEqualTo: false)
        .orderBy(
            'dayOfWeek') // You might want to order by day and then startTime
        .orderBy('startTime')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AvailabilitySlotModel.fromSnapshot(doc))
          .toList();
    });
  }

  // Update an availability slot (e.g., to mark as booked)
  Future<void> updateAvailabilitySlot(
      String slotId, AvailabilitySlotModel slot) async {
    try {
      await _firestore
          .collection(_collectionPath)
          .doc(slotId)
          .update(slot.toJson());
    } catch (e) {
      print('Error updating availability slot: $e');
      rethrow;
    }
  }

  // Delete an availability slot
  Future<void> deleteAvailabilitySlot(String slotId) async {
    try {
      await _firestore.collection(_collectionPath).doc(slotId).delete();
    } catch (e) {
      print('Error deleting availability slot: $e');
      rethrow;
    }
  }

  // Helper to book a slot
  Future<void> bookSlot(String slotId, String patientId) async {
    try {
      await _firestore.collection(_collectionPath).doc(slotId).update({
        'isBooked': true,
        'bookedByPatientId': patientId,
      });
    } catch (e) {
      print('Error booking slot: $e');
      rethrow;
    }
  }

  // Helper to unbook a slot (e.g., if an appointment is cancelled)
  Future<void> unbookSlot(String slotId) async {
    try {
      await _firestore.collection(_collectionPath).doc(slotId).update({
        'isBooked': false,
        'bookedByPatientId':
            null, // Or FieldValue.delete() if you want to remove the field
      });
    } catch (e) {
      print('Error unbooking slot: $e');
      rethrow;
    }
  }
}
