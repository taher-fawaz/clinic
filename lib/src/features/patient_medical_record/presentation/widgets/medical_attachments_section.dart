import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinic/src/core/res/app_res.dart';

import '../../data/models/medical_file_model.dart';
import '../pages/all_medical_attachments_screen.dart';

class MedicalAttachmentsSection extends StatefulWidget {
  final List<MedicalFileModel> attachments;

  const MedicalAttachmentsSection({
    super.key,
    required this.attachments,
  });

  @override
  State<MedicalAttachmentsSection> createState() =>
      _MedicalAttachmentsSectionState();
}

class _MedicalAttachmentsSectionState extends State<MedicalAttachmentsSection> {
  bool _isGridView = true;
  String _selectedFilter = 'all';

  List<MedicalFileModel> get _filteredAttachments {
    if (_selectedFilter == 'all') {
      return widget.attachments;
    }
    return widget.attachments.where((file) {
      switch (_selectedFilter) {
        case 'images':
          return file.isImage;
        case 'pdfs':
          return file.isPdf;
        case 'documents':
          return file.isDocument;
        default:
          return true;
      }
    }).toList();
  }

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
          _buildHeader(),
          const SizedBox(height: 16),
          if (widget.attachments.isNotEmpty) _buildFilterRow(),
          if (widget.attachments.isNotEmpty) const SizedBox(height: 16),
          if (_filteredAttachments.isEmpty)
            _buildEmptyState()
          else
            _buildAttachmentsList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(
          Icons.attach_file_outlined,
          color: ColorManager.primary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          'medicalRecord.attachments.title'.tr(),
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
            _filteredAttachments.length.toString(),
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
                builder: (context) => AllMedicalAttachmentsScreen(
                  attachments: widget.attachments,
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
        if (widget.attachments.isNotEmpty) ...[
          const SizedBox(width: 8),
          _buildViewToggle(),
        ],
      ],
    );
  }

  Widget _buildViewToggle() {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.backgroundPrimary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorManager.borderFocus,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton(
            icon: Icons.grid_view,
            isSelected: _isGridView,
            onTap: () => setState(() => _isGridView = true),
          ),
          _buildToggleButton(
            icon: Icons.list,
            isSelected: !_isGridView,
            onTap: () => setState(() => _isGridView = false),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 16,
          color:
              isSelected ? ColorManager.onPrimary : ColorManager.textSecondary,
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    final filters = [
      {'key': 'all', 'label': 'medicalRecord.attachments.filter.all'.tr()},
      {
        'key': 'images',
        'label': 'medicalRecord.attachments.filter.images'.tr()
      },
      {'key': 'pdfs', 'label': 'medicalRecord.attachments.filter.pdfs'.tr()},
      {
        'key': 'documents',
        'label': 'medicalRecord.attachments.filter.documents'.tr()
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = _selectedFilter == filter['key'];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = filter['key']!),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorManager.primary
                      : ColorManager.backgroundPrimary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? ColorManager.primary
                        : ColorManager.borderFocus,
                    width: 1,
                  ),
                ),
                child: Text(
                  filter['label']!,
                  style: TextStyleManager.getMediumStyle(
                    fontSize: FontSize.s12,
                    color: isSelected
                        ? ColorManager.onPrimary
                        : ColorManager.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
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
              Icons.attach_file_outlined,
              size: 48,
              color: ColorManager.textSecondary.withOpacity(0.5),
            ),
            const SizedBox(height: 12),
            Text(
              widget.attachments.isEmpty
                  ? 'medicalRecord.attachments.empty'.tr()
                  : 'medicalRecord.attachments.noFiltered'.tr(),
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

  Widget _buildAttachmentsList() {
    if (_isGridView) {
      return _buildGridView();
    } else {
      return _buildListView();
    }
  }

  Widget _buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: _filteredAttachments.length,
      itemBuilder: (context, index) {
        return _buildGridItem(_filteredAttachments[index]);
      },
    );
  }

  Widget _buildListView() {
    return Column(
      children: _filteredAttachments.asMap().entries.map((entry) {
        final index = entry.key;
        final file = entry.value;
        return Column(
          children: [
            _buildListItem(file),
            if (index < _filteredAttachments.length - 1)
              const SizedBox(height: 8),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildGridItem(MedicalFileModel file) {
    return GestureDetector(
      onTap: () => _showFileDetails(file),
      child: Container(
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
            Expanded(
              child: Center(
                child: _buildFileIcon(file),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              file.fileName,
              style: TextStyleManager.getMediumStyle(
                fontSize: FontSize.s12,
                color: ColorManager.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              file.formattedFileSize,
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s10,
                color: ColorManager.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(MedicalFileModel file) {
    return GestureDetector(
      onTap: () => _showFileDetails(file),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorManager.backgroundPrimary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: ColorManager.borderFocus,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            _buildFileIcon(file),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    file.fileName,
                    style: TextStyleManager.getMediumStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (file.description != null)
                    Text(
                      file.description!,
                      style: TextStyleManager.getRegularStyle(
                        fontSize: FontSize.s12,
                        color: ColorManager.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        file.formattedFileSize,
                        style: TextStyleManager.getRegularStyle(
                          fontSize: FontSize.s12,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: TextStyleManager.getRegularStyle(
                          fontSize: FontSize.s12,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        file.formattedUploadedAt,
                        style: TextStyleManager.getRegularStyle(
                          fontSize: FontSize.s12,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: ColorManager.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileIcon(MedicalFileModel file) {
    IconData iconData;
    Color iconColor;

    if (file.isImage) {
      iconData = Icons.image_outlined;
      iconColor = Colors.blue;
    } else if (file.isPdf) {
      iconData = Icons.picture_as_pdf_outlined;
      iconColor = Colors.red;
    } else if (file.isDocument) {
      iconData = Icons.description_outlined;
      iconColor = Colors.green;
    } else {
      iconData = Icons.insert_drive_file_outlined;
      iconColor = ColorManager.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        iconData,
        size: _isGridView ? 32 : 24,
        color: iconColor,
      ),
    );
  }

  void _showFileDetails(MedicalFileModel file) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildFileDetailsSheet(file),
    );
  }

  Widget _buildFileDetailsSheet(MedicalFileModel file) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorManager.backgroundSecondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildFileIcon(file),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  file.fileName,
                  style: TextStyleManager.getSemiBoldStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close,
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (file.description != null) ...[
            _buildDetailRow('medicalRecord.attachments.description'.tr(),
                file.description!),
            const SizedBox(height: 12),
          ],
          _buildDetailRow('medicalRecord.attachments.fileSize'.tr(),
              file.formattedFileSize),
          const SizedBox(height: 12),
          _buildDetailRow(
              'medicalRecord.attachments.uploadedBy'.tr(), file.uploaderName),
          const SizedBox(height: 12),
          _buildDetailRow('medicalRecord.attachments.uploadedAt'.tr(),
              file.formattedUploadedAt),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement file download
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.download),
                  label: Text('medicalRecord.attachments.download'.tr()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implement file preview
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.visibility),
                  label: Text('medicalRecord.attachments.preview'.tr()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyleManager.getRegularStyle(
            fontSize: FontSize.s12,
            color: ColorManager.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyleManager.getMediumStyle(
            fontSize: FontSize.s14,
            color: ColorManager.textPrimary,
          ),
        ),
      ],
    );
  }
}
