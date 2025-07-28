import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import '../res/app_res.dart';
import '../../features/home/data/models/doctor_work_model.dart';

/// Service class for handling sharing functionality
class SharingService {
  static const SharingService _instance = SharingService._internal();
  factory SharingService() => _instance;
  const SharingService._internal();

  /// Share doctor work case with multiple options
  static Future<void> shareDoctorWork({
    required BuildContext context,
    required DoctorWorkModel work,
  }) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSize.s20),
        ),
      ),
      builder: (context) => _ShareBottomSheet(work: work),
    );
  }

  /// Share as text
  static Future<void> shareAsText(DoctorWorkModel work) async {
    final text = _buildShareText(work);
    await Share.share(
      text,
      subject: work.title,
    );
  }

  /// Share with images
  static Future<void> shareWithImages(DoctorWorkModel work) async {
    final text = _buildShareText(work);

    // Note: In a real app, you would download the images first
    // For now, we'll share the text with image URLs
    await Share.share(
      '$text\n\n${'doctorWorks.before'.tr()}: ${work.beforeImageUrl}\n${'doctorWorks.after'.tr()}: ${work.afterImageUrl}',
      subject: work.title,
    );
  }

  /// Copy to clipboard
  static Future<void> copyToClipboard({
    required BuildContext context,
    required DoctorWorkModel work,
  }) async {
    final text = _buildShareText(work);
    await Clipboard.setData(ClipboardData(text: text));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'sharing.copiedToClipboard'.tr(),
            style: TextStyleManager.getMediumStyle(
              fontSize: FontSize.s14,
              color: ColorManager.onPrimary,
            ),
          ),
          backgroundColor: ColorManager.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
          ),
        ),
      );
    }
  }

  /// Build formatted text for sharing
  static String _buildShareText(DoctorWorkModel work) {
    return '''
${work.title}

${'doctorWorks.treatmentBy'.tr()}: ${'common.doctor'.tr()} ${work.doctorName}
${'common.specialty'.tr()}: ${work.specialty}
${'doctorWorks.treatmentType'.tr()}: ${work.treatmentType}
${'doctorWorks.duration'.tr()}: ${work.duration}

${work.description}

${'doctorWorks.tags'.tr()}: ${work.tags.join(', ')}

${'common.date'.tr()}: ${work.createdAt.toString().split(' ')[0]}
''';
  }
}

/// Bottom sheet widget for sharing options
class _ShareBottomSheet extends StatelessWidget {
  final DoctorWorkModel work;

  const _ShareBottomSheet({required this.work});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: ColorManager.grey,
              borderRadius: BorderRadius.circular(AppSize.s2),
            ),
          ),
          const SizedBox(height: AppSize.s20),

          // Title
          Text(
            'sharing.shareCase'.tr(),
            style: TextStyleManager.getSemiBoldStyle(
              fontSize: FontSize.s18,
              color: ColorManager.textPrimary,
            ),
          ),
          const SizedBox(height: AppSize.s24),

          // Share options
          _ShareOption(
            icon: Icons.share,
            title: 'sharing.shareAsText'.tr(),
            subtitle: 'sharing.shareAsTextSubtitle'.tr(),
            onTap: () {
              Navigator.pop(context);
              SharingService.shareAsText(work);
            },
          ),
          const SizedBox(height: AppSize.s16),

          _ShareOption(
            icon: Icons.image,
            title: 'sharing.shareWithImages'.tr(),
            subtitle: 'sharing.shareWithImagesSubtitle'.tr(),
            onTap: () {
              Navigator.pop(context);
              SharingService.shareWithImages(work);
            },
          ),
          const SizedBox(height: AppSize.s16),

          _ShareOption(
            icon: Icons.copy,
            title: 'sharing.copyToClipboard'.tr(),
            subtitle: 'sharing.copyToClipboardSubtitle'.tr(),
            onTap: () {
              Navigator.pop(context);
              SharingService.copyToClipboard(
                context: context,
                work: work,
              );
            },
          ),

          const SizedBox(height: AppSize.s20),
        ],
      ),
    );
  }
}

/// Individual share option widget
class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ShareOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s12),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorManager.border,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSize.s8),
              ),
              child: Icon(
                icon,
                color: ColorManager.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSize.s16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyleManager.getMediumStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSize.s4),
                  Text(
                    subtitle,
                    style: TextStyleManager.getRegularStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
