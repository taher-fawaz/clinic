import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinic/src/core/res/app_res.dart';
import 'package:clinic/src/features/home/data/models/doctor_work_model.dart';

class DoctorWorkCard extends StatefulWidget {
  final DoctorWorkModel work;
  final VoidCallback onTap;

  const DoctorWorkCard({
    super.key,
    required this.work,
    required this.onTap,
  });

  @override
  State<DoctorWorkCard> createState() => _DoctorWorkCardState();
}

class _DoctorWorkCardState extends State<DoctorWorkCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: 2.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHoverChanged(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) => _onHoverChanged(true),
            onExit: (_) => _onHoverChanged(false),
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.surface,
                  borderRadius: BorderRadius.circular(AppSize.s16),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.shadowColor,
                      blurRadius: _elevationAnimation.value,
                      offset: Offset(0, _elevationAnimation.value / 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageSection(),
                    _buildContentSection(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSection() {
    return Expanded(
      flex: 3,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppSize.s16),
            topRight: Radius.circular(AppSize.s16),
          ),
          gradient: ColorManager.primaryGradient,
        ),
        child: Stack(
          children: [
            _buildBeforeAfterImages(),
            _buildImageOverlay(),
            _buildTreatmentBadge(),
          ],
        ),
      ),
    );
  }

  Widget _buildBeforeAfterImages() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppSize.s16),
        topRight: Radius.circular(AppSize.s16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  widget.work.beforeImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: ColorManager.greyLight,
                      child: Icon(
                        Icons.image_not_supported,
                        color: ColorManager.grey,
                        size: AppSize.s24,
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: AppSize.s8,
                  left: AppSize.s8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p6,
                      vertical: AppPadding.p2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(AppSize.s4),
                    ),
                    child: Text(
                      'doctorWorks.before'.tr(),
                      style: TextStyleManager.getRegularStyle(
                        fontSize: FontSize.s10,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            color: ColorManager.white.withOpacity(0.3),
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  widget.work.afterImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: ColorManager.greyLight,
                      child: Icon(
                        Icons.image_not_supported,
                        color: ColorManager.grey,
                        size: AppSize.s24,
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: AppSize.s8,
                  right: AppSize.s8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p6,
                      vertical: AppPadding.p2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(AppSize.s4),
                    ),
                    child: Text(
                      'doctorWorks.after'.tr(),
                      style: TextStyleManager.getRegularStyle(
                        fontSize: FontSize.s10,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageOverlay() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSize.s16),
          topRight: Radius.circular(AppSize.s16),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.1),
          ],
        ),
      ),
    );
  }

  Widget _buildTreatmentBadge() {
    return Positioned(
      top: AppSize.s8,
      right: AppSize.s8,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p8,
          vertical: AppPadding.p4,
        ),
        decoration: BoxDecoration(
          color: ColorManager.success.withOpacity(0.9),
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        child: Text(
          widget.work.treatmentType,
          style: TextStyleManager.getMediumStyle(
            fontSize: FontSize.s10,
            color: ColorManager.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            const SizedBox(height: AppSize.s4),
            _buildDoctorInfo(),
            const Spacer(),
            _buildTagsAndDuration(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.work.title,
      style: TextStyleManager.getBoldStyle(
        fontSize: FontSize.s14,
        color: ColorManager.textPrimary,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDoctorInfo() {
    return Row(
      children: [
        Icon(
          Icons.person_outline,
          size: AppSize.s12,
          color: ColorManager.textSecondary,
        ),
        const SizedBox(width: AppSize.s4),
        Expanded(
          child: Text(
            widget.work.doctorName,
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s12,
              color: ColorManager.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildTagsAndDuration() {
    return Row(
      children: [
        if (widget.work.tags.isNotEmpty)
          ...widget.work.tags.take(2).map(
                (tag) => Container(
                  margin: const EdgeInsets.only(right: AppMargin.m4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p6,
                    vertical: AppPadding.p2,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                  child: Text(
                    tag,
                    style: TextStyleManager.getRegularStyle(
                      fontSize: FontSize.s10,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
              ),
        const Spacer(),
        Icon(
          Icons.access_time,
          size: AppSize.s10,
          color: ColorManager.textSecondary,
        ),
        const SizedBox(width: AppSize.s2),
        Flexible(
          child: Text(
            widget.work.duration,
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s10,
              color: ColorManager.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
