import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinic/src/core/res/app_res.dart';

import '../../data/models/medical_record_model.dart';
import '../pages/all_doctor_notes_screen.dart';

class DoctorNotesSection extends StatelessWidget {
  final List<DoctorNote> notes;

  const DoctorNotesSection({
    super.key,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Icon(
                Icons.note_alt_outlined,
                color: ColorManager.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'medicalRecord.notes.title'.tr(),
                style: TextStyleManager.getSemiBoldStyle(
                  fontSize: FontSize.s16,
                  color: ColorManager.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: ColorManager.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  notes.length.toString(),
                  style: TextStyleManager.getMediumStyle(
                    fontSize: FontSize.s12,
                    color: ColorManager.primary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllDoctorNotesScreen(
                        notes: notes,
                      ),
                    ),
                  );
                },
                child: Text(
                    'common.seeAll'.tr(),
                    style: TextStyleManager.getMediumStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.primary,
                    ),
                  ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (notes.isEmpty) _buildEmptyState() else _buildNotesList(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Icon(
              Icons.note_alt_outlined,
              size: 48,
              color: ColorManager.textSecondary.withOpacity(0.5),
            ),
            const SizedBox(height: 12),
            Text(
              'medicalRecord.notes.empty'.tr(),
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s14,
                color: ColorManager.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesList() {
    return Column(
      children: notes.asMap().entries.map((entry) {
        final index = entry.key;
        final note = entry.value;
        return Column(
          children: [
            _buildNoteCard(note),
            if (index < notes.length - 1) const SizedBox(height: 12),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildNoteCard(DoctorNote note) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorManager.backgroundPrimary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorManager.borderFocus,
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
                    fontSize: FontSize.s14,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ),
              Text(
                note.formattedCreatedAt,
                style: TextStyleManager.getRegularStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            note.content,
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 14,
                color: ColorManager.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                note.doctorName,
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
        iconColor = Colors.blue;
        break;
      case 'follow_up':
        iconData = Icons.follow_the_signs_outlined;
        iconColor = Colors.green;
        break;
      case 'diagnosis':
        iconData = Icons.medical_services_outlined;
        iconColor = Colors.orange;
        break;
      case 'treatment':
        iconData = Icons.healing_outlined;
        iconColor = Colors.purple;
        break;
      case 'general':
      default:
        iconData = Icons.note_outlined;
        iconColor = ColorManager.primary;
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        iconData,
        size: 16,
        color: iconColor,
      ),
    );
  }
}
