import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinic/src/core/res/app_res.dart';

import '../../data/models/medical_record_model.dart';
import '../pages/all_medical_conditions_screen.dart';

class MedicalConditionsSection extends StatelessWidget {
  final List<MedicalCondition> conditions;

  const MedicalConditionsSection({
    super.key,
    required this.conditions,
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
                Icons.medical_information_outlined,
                color: ColorManager.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'medicalRecord.conditions.title'.tr(),
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
                  conditions.length.toString(),
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
                      builder: (context) => AllMedicalConditionsScreen(
                        conditions: conditions,
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
          if (conditions.isEmpty)
            _buildEmptyState()
          else
            _buildConditionsList(),
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
              Icons.medical_information_outlined,
              size: 48,
              color: ColorManager.textSecondary.withOpacity(0.5),
            ),
            const SizedBox(height: 12),
            Text(
              'medicalRecord.conditions.empty'.tr(),
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

  Widget _buildConditionsList() {
    return Column(
      children: conditions.asMap().entries.map((entry) {
        final index = entry.key;
        final condition = entry.value;
        return Column(
          children: [
            _buildConditionCard(condition),
            if (index < conditions.length - 1) const SizedBox(height: 12),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildConditionCard(MedicalCondition condition) {
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
              Expanded(
                child: Text(
                  condition.name,
                  style: TextStyleManager.getSemiBoldStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _buildSeverityBadge(condition.severity),
              const SizedBox(width: 8),
              _buildStatusBadge(condition.isActive),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            condition.description,
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s12,
              color: ColorManager.textSecondary,
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
                condition.doctorName,
                style: TextStyleManager.getRegularStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.textSecondary,
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: ColorManager.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                condition.formattedDiagnosedAt,
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

  Widget _buildSeverityBadge(String severity) {
    Color backgroundColor;
    Color textColor;

    switch (severity.toLowerCase()) {
      case 'mild':
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        break;
      case 'moderate':
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        break;
      case 'severe':
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        break;
      default:
        backgroundColor = ColorManager.textSecondary.withOpacity(0.1);
        textColor = ColorManager.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'medicalRecord.conditions.severity.${severity.toLowerCase()}'.tr(),
        style: TextStyleManager.getMediumStyle(
          fontSize: FontSize.s10,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isActive
            ? ColorManager.primary.withOpacity(0.1)
            : ColorManager.textSecondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isActive
            ? 'medicalRecord.conditions.status.active'.tr()
            : 'medicalRecord.conditions.status.inactive'.tr(),
        style: TextStyleManager.getMediumStyle(
          fontSize: FontSize.s10,
          color: isActive ? ColorManager.primary : ColorManager.textSecondary,
        ),
      ),
    );
  }
}
