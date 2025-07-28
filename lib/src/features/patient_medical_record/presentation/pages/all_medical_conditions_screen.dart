import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../data/models/medical_record_model.dart';
import 'package:clinic/src/core/res/app_res.dart';

class AllMedicalConditionsScreen extends StatelessWidget {
  final List<MedicalCondition> conditions;

  const AllMedicalConditionsScreen({
    Key? key,
    required this.conditions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'medicalRecord.conditions.allTitle'.tr(),
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
      body: conditions.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: conditions.length,
              itemBuilder: (context, index) {
                final condition = conditions[index];
                return _buildConditionCard(condition);
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
            Icons.medical_information_outlined,
            size: 64,
            color: ColorManager.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'medicalRecord.conditions.empty'.tr(),
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

  Widget _buildConditionCard(MedicalCondition condition) {
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
              Expanded(
                child: Text(
                  condition.name,
                  style: TextStyleManager.getSemiBoldStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ),
              _buildSeverityChip(condition.severity),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildStatusChip(condition.isActive ? 'active' : 'inactive'),
              const Spacer(),
              Text(
                condition.formattedDiagnosedAt,
                style: TextStyleManager.getRegularStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
          ),
          if (condition.description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              condition.description,
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s14,
                color: ColorManager.textSecondary,
              ),
            ),
          ],
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
                'medicalRecord.conditions.diagnosedBy'.tr(),
                style: TextStyleManager.getRegularStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.textSecondary,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                condition.doctorName,
                style: TextStyleManager.getMediumStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSeverityChip(String severity) {
    Color chipColor;
    switch (severity.toLowerCase()) {
      case 'mild':
        chipColor = Colors.green;
        break;
      case 'moderate':
        chipColor = Colors.orange;
        break;
      case 'severe':
        chipColor = Colors.red;
        break;
      default:
        chipColor = ColorManager.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'medicalRecord.conditions.severity.$severity'.tr(),
        style: TextStyleManager.getMediumStyle(
          fontSize: FontSize.s10,
          color: chipColor,
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    switch (status.toLowerCase()) {
      case 'active':
        chipColor = Colors.red;
        break;
      case 'resolved':
        chipColor = Colors.green;
        break;
      case 'chronic':
        chipColor = Colors.orange;
        break;
      case 'monitoring':
        chipColor = Colors.blue;
        break;
      case 'inactive':
        chipColor = Colors.grey;
        break;
      default:
        chipColor = ColorManager.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'medicalRecord.conditions.status.$status'.tr(),
        style: TextStyleManager.getMediumStyle(
          fontSize: FontSize.s10,
          color: chipColor,
        ),
      ),
    );
  }
}
