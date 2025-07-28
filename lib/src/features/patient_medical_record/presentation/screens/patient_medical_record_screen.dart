import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinic/src/core/res/app_res.dart';

import '../../data/models/medical_record_model.dart';
import '../../data/models/medical_file_model.dart';
import '../widgets/medical_conditions_section.dart';
import '../widgets/doctor_notes_section.dart';
import '../widgets/medical_attachments_section.dart';

class PatientMedicalRecordScreen extends StatefulWidget {
  const PatientMedicalRecordScreen({super.key});

  @override
  State<PatientMedicalRecordScreen> createState() =>
      _PatientMedicalRecordScreenState();
}

class _PatientMedicalRecordScreenState
    extends State<PatientMedicalRecordScreen> {
  MedicalRecordModel? _medicalRecord;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMedicalRecord();
  }

  Future<void> _loadMedicalRecord() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Generate mock data
      final mockRecord = _generateMockMedicalRecord();

      setState(() {
        _medicalRecord = mockRecord;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  MedicalRecordModel _generateMockMedicalRecord() {
    return MedicalRecordModel(
      id: 'mr_001',
      patientId: 'patient_001',
      patientName: 'John Doe',
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      updatedAt: DateTime.now().subtract(const Duration(days: 7)),
      conditions: [
        MedicalCondition(
          id: 'cond_001',
          name: 'Hypertension',
          description:
              'High blood pressure requiring medication and lifestyle changes',
          severity: 'moderate',
          diagnosedAt: DateTime.now().subtract(const Duration(days: 180)),
          doctorId: 'doc_001',
          doctorName: 'Dr. Sarah Johnson',
          isActive: true,
        ),
        MedicalCondition(
          id: 'cond_002',
          name: 'Type 2 Diabetes',
          description:
              'Diabetes mellitus type 2, well controlled with medication',
          severity: 'mild',
          diagnosedAt: DateTime.now().subtract(const Duration(days: 90)),
          doctorId: 'doc_002',
          doctorName: 'Dr. Michael Chen',
          isActive: true,
        ),
        MedicalCondition(
          id: 'cond_003',
          name: 'Seasonal Allergies',
          description: 'Allergic rhinitis, seasonal pattern',
          severity: 'mild',
          diagnosedAt: DateTime.now().subtract(const Duration(days: 300)),
          doctorId: 'doc_001',
          doctorName: 'Dr. Sarah Johnson',
          isActive: false,
        ),
      ],
      notes: [
        DoctorNote(
          id: 'note_001',
          content:
              'Patient shows good compliance with medication. Blood pressure readings have improved significantly over the past month.',
          createdAt: DateTime.now().subtract(const Duration(days: 7)),
          doctorId: 'doc_001',
          doctorName: 'Dr. Sarah Johnson',
          type: 'follow_up',
        ),
        DoctorNote(
          id: 'note_002',
          content:
              'Prescribed Metformin 500mg twice daily. Patient advised to monitor blood glucose levels and maintain low-carb diet.',
          createdAt: DateTime.now().subtract(const Duration(days: 14)),
          doctorId: 'doc_002',
          doctorName: 'Dr. Michael Chen',
          type: 'prescription',
        ),
        DoctorNote(
          id: 'note_003',
          content:
              'Regular check-up completed. All vital signs within normal range. Continue current treatment plan.',
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
          doctorId: 'doc_001',
          doctorName: 'Dr. Sarah Johnson',
          type: 'general',
        ),
      ],
      attachments: [
        MedicalFileModel(
          id: 'file_001',
          fileName: 'blood_test_results.pdf',
          filePath: '/medical_files/blood_test_results.pdf',
          fileType: 'pdf',
          mimeType: 'application/pdf',
          fileSize: 245760, // 240 KB
          uploadedAt: DateTime.now().subtract(const Duration(days: 14)),
          uploadedBy: 'doc_002',
          uploaderName: 'Dr. Michael Chen',
          description: 'Complete blood count and glucose levels',
        ),
        MedicalFileModel(
          id: 'file_002',
          fileName: 'chest_xray.jpg',
          filePath: '/medical_files/chest_xray.jpg',
          fileType: 'image',
          mimeType: 'image/jpeg',
          fileSize: 1048576, // 1 MB
          uploadedAt: DateTime.now().subtract(const Duration(days: 21)),
          uploadedBy: 'doc_001',
          uploaderName: 'Dr. Sarah Johnson',
          description: 'Chest X-ray - routine examination',
          thumbnailPath: '/medical_files/thumbnails/chest_xray_thumb.jpg',
        ),
        MedicalFileModel(
          id: 'file_003',
          fileName: 'ecg_report.pdf',
          filePath: '/medical_files/ecg_report.pdf',
          fileType: 'pdf',
          mimeType: 'application/pdf',
          fileSize: 512000, // 500 KB
          uploadedAt: DateTime.now().subtract(const Duration(days: 35)),
          uploadedBy: 'doc_001',
          uploaderName: 'Dr. Sarah Johnson',
          description: 'Electrocardiogram results',
        ),
        MedicalFileModel(
          id: 'file_004',
          fileName: 'prescription_scan.jpg',
          filePath: '/medical_files/prescription_scan.jpg',
          fileType: 'image',
          mimeType: 'image/jpeg',
          fileSize: 768000, // 750 KB
          uploadedAt: DateTime.now().subtract(const Duration(days: 7)),
          uploadedBy: 'doc_002',
          uploaderName: 'Dr. Michael Chen',
          description: 'Prescription for diabetes medication',
          thumbnailPath:
              '/medical_files/thumbnails/prescription_scan_thumb.jpg',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundPrimary,
      appBar: AppBar(
        title: Text(
          'medicalRecord.title'.tr(),
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s18,
            color: ColorManager.onPrimary,
          ),
        ),
        backgroundColor: ColorManager.primary,
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: ColorManager.error,
            ),
            const SizedBox(height: 16),
            Text(
              'common.error'.tr(),
              style: TextStyleManager.getSemiBoldStyle(
                fontSize: FontSize.s16,
                color: ColorManager.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s14,
                color: ColorManager.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadMedicalRecord,
              child: Text('common.retry'.tr()),
            ),
          ],
        ),
      );
    }

    if (_medicalRecord == null) {
      return Center(
        child: Text(
          'medicalRecord.noData'.tr(),
          style: TextStyleManager.getRegularStyle(
            fontSize: FontSize.s16,
            color: ColorManager.textSecondary,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadMedicalRecord,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPatientInfo(),
            const SizedBox(height: 24),
            MedicalConditionsSection(conditions: _medicalRecord!.conditions),
            const SizedBox(height: 24),
            DoctorNotesSection(notes: _medicalRecord!.notes),
            const SizedBox(height: 24),
            MedicalAttachmentsSection(attachments: _medicalRecord!.attachments),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientInfo() {
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
          Text(
            'medicalRecord.patientInfo.title'.tr(),
            style: TextStyleManager.getSemiBoldStyle(
              fontSize: FontSize.s16,
              color: ColorManager.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'common.name'.tr(),
                      style: TextStyleManager.getRegularStyle(
                        fontSize: FontSize.s12,
                        color: ColorManager.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _medicalRecord!.patientName,
                      style: TextStyleManager.getMediumStyle(
                        fontSize: FontSize.s14,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'medicalRecord.lastUpdated'.tr(),
                      style: TextStyleManager.getRegularStyle(
                        fontSize: FontSize.s12,
                        color: ColorManager.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _medicalRecord!.formattedUpdatedAt,
                      style: TextStyleManager.getMediumStyle(
                        fontSize: FontSize.s14,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
