import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../data/models/medical_record_model.dart';
import 'package:clinic/src/core/res/app_res.dart';

class AllDoctorNotesScreen extends StatelessWidget {
  final List<DoctorNote> notes;

  const AllDoctorNotesScreen({
    Key? key,
    required this.notes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'medicalRecord.notes.allTitle'.tr(),
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s18,
            color: ColorManager.textPrimary,
          ),
        ),
        backgroundColor: ColorManager.backgroundPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorManager.textPrimary),
      ),
      backgroundColor: ColorManager.backgroundPrimary,
      body: notes.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return _buildNoteCard(note);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_alt_outlined,
            size: 64,
            color: ColorManager.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'medicalRecord.notes.empty'.tr(),
            style: TextStyleManager.getMediumStyle(
              fontSize: FontSize.s16,
              color: ColorManager.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard(DoctorNote note) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorManager.border,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildNoteTypeIcon(note.type),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'medicalRecord.notes.type.${note.type}'.tr(),
                  style: TextStyleManager.getSemiBoldStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ),
              Text(
                DateFormat('MMM dd, yyyy').format(note.createdAt),
                style: TextStyleManager.getRegularStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            note.content,
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 16,
                color: ColorManager.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                note.doctorName,
                style: TextStyleManager.getMediumStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                DateFormat('hh:mm a').format(note.createdAt),
                style: TextStyleManager.getRegularStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoteTypeIcon(String type) {
    IconData iconData;
    Color iconColor;

    switch (type.toLowerCase()) {
      case 'prescription':
        iconData = Icons.medication_outlined;
        iconColor = Colors.green;
        break;
      case 'follow_up':
        iconData = Icons.schedule_outlined;
        iconColor = Colors.blue;
        break;
      case 'diagnosis':
        iconData = Icons.medical_information_outlined;
        iconColor = Colors.red;
        break;
      case 'treatment':
        iconData = Icons.healing_outlined;
        iconColor = Colors.orange;
        break;
      case 'general':
      default:
        iconData = Icons.note_outlined;
        iconColor = ColorManager.primary;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        iconData,
        size: 16,
        color: iconColor,
      ),
    );
  }
}
