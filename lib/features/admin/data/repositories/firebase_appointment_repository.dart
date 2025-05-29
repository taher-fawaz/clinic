import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';
import 'package:clinic/features/appointment/data/models/appointment_model.dart';

class FirebaseAppointmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'appointments';

  // Get all appointments
  Stream<List<AppointmentEntity>> getAppointments() {
    return _firestore
        .collection(_collection)
        .orderBy('appointmentDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        // Convert Timestamp to DateTime
        final appointmentDate = (data['appointmentDate'] as Timestamp).toDate();

        return AppointmentModel(
          id: doc.id,
          patientId: data['patientId'] ?? '',
          doctorId: data['doctorId'] ?? '',
          appointmentDate: appointmentDate,
          status: data['status'] ?? 'pending',
          notes: data['notes'] ?? '',
        );
      }).toList();
    });
  }

  // Get pending appointments
  Stream<List<AppointmentEntity>> getPendingAppointments() {
    return _firestore
        .collection(_collection)
        .where('status', isEqualTo: 'pending')
        .orderBy('appointmentDate', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        final appointmentDate = (data['appointmentDate'] as Timestamp).toDate();

        return AppointmentModel(
          id: doc.id,
          patientId: data['patientId'] ?? '',
          doctorId: data['doctorId'] ?? '',
          appointmentDate: appointmentDate,
          status: data['status'] ?? 'pending',
          notes: data['notes'] ?? '',
        );
      }).toList();
    });
  }

  // Get processed appointments (approved or rejected)
  Stream<List<AppointmentEntity>> getProcessedAppointments() {
    return _firestore
        .collection(_collection)
        .where('status', whereIn: ['approved', 'rejected'])
        .orderBy('appointmentDate', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            final appointmentDate =
                (data['appointmentDate'] as Timestamp).toDate();

            return AppointmentModel(
              id: doc.id,
              patientId: data['patientId'] ?? '',
              doctorId: data['doctorId'] ?? '',
              appointmentDate: appointmentDate,
              status: data['status'] ?? '',
              notes: data['notes'] ?? '',
            );
          }).toList();
        });
  }

  // Update appointment status
  Future<void> updateAppointmentStatus(
      String appointmentId, String status) async {
    try {
      await _firestore.collection(_collection).doc(appointmentId).update({
        'status': status,
      });
    } catch (e) {
      throw Exception('Failed to update appointment status: $e');
    }
  }
}
