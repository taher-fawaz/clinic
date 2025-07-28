import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../data/models/medical_file_model.dart';
import 'package:clinic/src/core/res/app_res.dart';

class AllMedicalAttachmentsScreen extends StatefulWidget {
  final List<MedicalFileModel> attachments;

  const AllMedicalAttachmentsScreen({
    Key? key,
    required this.attachments,
  }) : super(key: key);

  @override
  State<AllMedicalAttachmentsScreen> createState() =>
      _AllMedicalAttachmentsScreenState();
}

class _AllMedicalAttachmentsScreenState
    extends State<AllMedicalAttachmentsScreen> {
  String _selectedFilter = 'all';
  bool _isGridView = true;

  List<MedicalFileModel> get _filteredAttachments {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'medicalRecord.attachments.allTitle'.tr(),
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s18,
            color: ColorManager.textPrimary,
          ),
        ),
        backgroundColor: ColorManager.backgroundPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorManager.textPrimary),
        actions: [
          IconButton(
            icon: Icon(
              _isGridView ? Icons.list : Icons.grid_view,
              color: ColorManager.textPrimary,
            ),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      backgroundColor: ColorManager.backgroundPrimary,
      body: Column(
        children: [
          if (widget.attachments.isNotEmpty) _buildFilterRow(),
          Expanded(
            child: _filteredAttachments.isEmpty
                ? _buildEmptyState()
                : _isGridView
                    ? _buildGridView()
                    : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip(
                'all', 'medicalRecord.attachments.filter.all'.tr()),
            const SizedBox(width: 8),
            _buildFilterChip(
                'images', 'medicalRecord.attachments.filter.images'.tr()),
            const SizedBox(width: 8),
            _buildFilterChip(
                'pdfs', 'medicalRecord.attachments.filter.pdfs'.tr()),
            const SizedBox(width: 8),
            _buildFilterChip(
                'documents', 'medicalRecord.attachments.filter.documents'.tr()),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = _selectedFilter == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.primary
              : ColorManager.backgroundSecondary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? ColorManager.primary : ColorManager.border,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyleManager.getMediumStyle(
            fontSize: FontSize.s12,
            color: isSelected ? Colors.white : ColorManager.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.attach_file_outlined,
            size: 64,
            color: ColorManager.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            _selectedFilter == 'all'
                ? 'medicalRecord.attachments.empty'.tr()
                : 'medicalRecord.attachments.noFiltered'.tr(),
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

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: _filteredAttachments.length,
      itemBuilder: (context, index) {
        final file = _filteredAttachments[index];
        return _buildFileGridItem(file);
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredAttachments.length,
      itemBuilder: (context, index) {
        final file = _filteredAttachments[index];
        return _buildFileListItem(file);
      },
    );
  }

  Widget _buildFileGridItem(MedicalFileModel file) {
    return GestureDetector(
      onTap: () => _showFileDetails(file),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.backgroundSecondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ColorManager.border,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _getFileTypeColor(file.fileType).withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Icon(
                  _getFileTypeIcon(file.fileType),
                  size: 48,
                  color: _getFileTypeColor(file.fileType),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.fileName,
                      style: TextStyleManager.getMediumStyle(
                        fontSize: FontSize.s12,
                        color: ColorManager.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileListItem(MedicalFileModel file) {
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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _getFileTypeColor(file.fileType).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getFileTypeIcon(file.fileType),
              color: _getFileTypeColor(file.fileType),
              size: 24,
            ),
          ),
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
                      DateFormat('MMM dd, yyyy').format(file.uploadedAt),
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
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: ColorManager.textSecondary,
            ),
            onPressed: () => _showFileDetails(file),
          ),
        ],
      ),
    );
  }

  IconData _getFileTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return Icons.image;
      case 'doc':
      case 'docx':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getFileTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Colors.red;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return Colors.blue;
      case 'doc':
      case 'docx':
        return Colors.indigo;
      default:
        return ColorManager.primary;
    }
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorManager.backgroundPrimary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ColorManager.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getFileTypeColor(file.fileType).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getFileTypeIcon(file.fileType),
                  color: _getFileTypeColor(file.fileType),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.fileName,
                      style: TextStyleManager.getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    Text(
                      file.formattedFileSize,
                      style: TextStyleManager.getRegularStyle(
                        fontSize: FontSize.s14,
                        color: ColorManager.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (file.description!.isNotEmpty) ...[
            _buildDetailItem(
              'medicalRecord.attachments.description'.tr(),
              file.description!,
            ),
            const SizedBox(height: 12),
          ],
          _buildDetailItem(
            'medicalRecord.attachments.uploadedBy'.tr(),
            file.uploadedBy,
          ),
          const SizedBox(height: 12),
          _buildDetailItem(
            'medicalRecord.attachments.uploadedAt'.tr(),
            DateFormat('MMM dd, yyyy - hh:mm a').format(file.uploadedAt),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement preview functionality
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.visibility),
                  label: Text('medicalRecord.attachments.preview'.tr()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implement download functionality
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.download),
                  label: Text('medicalRecord.attachments.download'.tr()),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorManager.primary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyleManager.getMediumStyle(
            fontSize: FontSize.s12,
            color: ColorManager.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyleManager.getRegularStyle(
            fontSize: FontSize.s14,
            color: ColorManager.textPrimary,
          ),
        ),
      ],
    );
  }
}
