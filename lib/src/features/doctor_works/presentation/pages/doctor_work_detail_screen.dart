import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinic/src/core/res/app_res.dart';
import 'package:clinic/src/core/utils/sharing_service.dart';
import 'package:clinic/src/features/home/data/models/doctor_work_model.dart';

class DoctorWorkDetailScreen extends StatefulWidget {
  final DoctorWorkModel work;

  const DoctorWorkDetailScreen({
    super.key,
    required this.work,
  });

  @override
  State<DoctorWorkDetailScreen> createState() => _DoctorWorkDetailScreenState();
}

class _DoctorWorkDetailScreenState extends State<DoctorWorkDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _imageController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _imageSlideAnimation;

  bool _showBeforeImage = true;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _animationController.forward();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _imageController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _imageSlideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _imageController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _toggleImage() {
    setState(() {
      _showBeforeImage = !_showBeforeImage;
    });
    _imageController.forward().then((_) {
      _imageController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundPrimary,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: CustomScrollView(
            slivers: [
              _buildAppBar(),
              _buildImageSection(),
              _buildContentSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: ColorManager.backgroundPrimary,
      elevation: 0,
      pinned: true,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(AppPadding.p8),
          decoration: BoxDecoration(
            color: ColorManager.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: ColorManager.shadowColor,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorManager.textPrimary,
            size: 16,
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(AppPadding.p8),
            decoration: BoxDecoration(
              color: ColorManager.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: ColorManager.shadowColor,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.share,
              color: ColorManager.textPrimary,
              size: 16,
            ),
          ),
          onPressed: () {
            SharingService.shareDoctorWork(
              context: context,
              work: widget.work,
            );
          },
        ),
        const SizedBox(width: AppSize.s16),
      ],
    );
  }

  Widget _buildImageSection() {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        margin: EdgeInsets.all(AppMargin.m20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s20),
          boxShadow: [
            BoxShadow(
              color: ColorManager.shadowColor,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            _buildImageCarousel(),
            _buildImageToggleButton(),
            _buildImageLabels(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.s20),
      child: AnimatedBuilder(
        animation: _imageSlideAnimation,
        builder: (context, child) {
          return Stack(
            children: [
              // Before Image
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(
                    _showBeforeImage ? 0 : -MediaQuery.of(context).size.width,
                    0,
                  ),
                  child: Image.network(
                    widget.work.beforeImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: ColorManager.greyLight,
                        child: Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: ColorManager.grey,
                            size: AppSize.s48,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // After Image
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(
                    _showBeforeImage ? MediaQuery.of(context).size.width : 0,
                    0,
                  ),
                  child: Image.network(
                    widget.work.afterImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: ColorManager.greyLight,
                        child: Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: ColorManager.grey,
                            size: AppSize.s48,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildImageToggleButton() {
    return Positioned(
      bottom: AppSize.s20,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: _toggleImage,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p20,
              vertical: AppPadding.p12,
            ),
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(AppSize.s24),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.primary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _showBeforeImage ? Icons.visibility : Icons.visibility_off,
                  color: ColorManager.white,
                  size: AppSize.s16,
                ),
                const SizedBox(width: AppSize.s8),
                Text(
                  _showBeforeImage
                      ? 'doctorWorks.showAfter'.tr()
                      : 'doctorWorks.showBefore'.tr(),
                  style: TextStyleManager.getMediumStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageLabels() {
    return Positioned(
      top: AppSize.s16,
      left: AppSize.s16,
      right: AppSize.s16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p12,
              vertical: AppPadding.p6,
            ),
            decoration: BoxDecoration(
              color: _showBeforeImage
                  ? ColorManager.error.withOpacity(0.9)
                  : Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            child: Text(
              'doctorWorks.before'.tr(),
              style: TextStyleManager.getMediumStyle(
                fontSize: FontSize.s12,
                color: ColorManager.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p12,
              vertical: AppPadding.p6,
            ),
            decoration: BoxDecoration(
              color: !_showBeforeImage
                  ? ColorManager.success.withOpacity(0.9)
                  : Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            child: Text(
              'doctorWorks.after'.tr(),
              style: TextStyleManager.getMediumStyle(
                fontSize: FontSize.s12,
                color: ColorManager.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
        padding: const EdgeInsets.all(AppPadding.p20),
        decoration: BoxDecoration(
          color: ColorManager.surface,
          borderRadius: BorderRadius.circular(AppSize.s20),
          boxShadow: [
            BoxShadow(
              color: ColorManager.shadowColor,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            const SizedBox(height: AppSize.s16),
            _buildDoctorInfo(),
            const SizedBox(height: AppSize.s20),
            _buildTreatmentDetails(),
            const SizedBox(height: AppSize.s20),
            _buildDescription(),
            const SizedBox(height: AppSize.s20),
            _buildTags(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.work.title,
      style: TextStyleManager.getBoldStyle(
        fontSize: FontSize.s24,
        color: ColorManager.textPrimary,
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppSize.s12),
        border: Border.all(
          color: ColorManager.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: AppSize.s48,
            height: AppSize.s48,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              color: ColorManager.white,
              size: AppSize.s24,
            ),
          ),
          const SizedBox(width: AppSize.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.work.doctorName,
                  style: TextStyleManager.getBoldStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSize.s4),
                Text(
                  widget.work.specialty,
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
    );
  }

  Widget _buildTreatmentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'doctorWorks.treatmentDetails'.tr(),
          style: TextStyleManager.getBoldStyle(
            fontSize: FontSize.s18,
            color: ColorManager.textPrimary,
          ),
        ),
        const SizedBox(height: AppSize.s12),
        _buildDetailRow(
          Icons.medical_services,
          'doctorWorks.treatmentType'.tr(),
          widget.work.treatmentType,
        ),
        const SizedBox(height: AppSize.s8),
        _buildDetailRow(
          Icons.access_time,
          'doctorWorks.duration'.tr(),
          widget.work.duration,
        ),
        const SizedBox(height: AppSize.s8),
        _buildDetailRow(
          Icons.calendar_today,
          'doctorWorks.date'.tr(),
          DateFormat('dd/MM/yyyy').format(widget.work.createdAt),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppSize.s16,
          color: ColorManager.primary,
        ),
        const SizedBox(width: AppSize.s8),
        Text(
          '$label: ',
          style: TextStyleManager.getMediumStyle(
            fontSize: FontSize.s14,
            color: ColorManager.textSecondary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'doctorWorks.description'.tr(),
          style: TextStyleManager.getBoldStyle(
            fontSize: FontSize.s18,
            color: ColorManager.textPrimary,
          ),
        ),
        const SizedBox(height: AppSize.s12),
        Text(
          widget.work.description,
          style: TextStyleManager.getRegularStyle(
            fontSize: FontSize.s14,
            color: ColorManager.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildTags() {
    if (widget.work.tags.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'doctorWorks.tags'.tr(),
          style: TextStyleManager.getBoldStyle(
            fontSize: FontSize.s18,
            color: ColorManager.textPrimary,
          ),
        ),
        const SizedBox(height: AppSize.s12),
        Wrap(
          spacing: AppSize.s8,
          runSpacing: AppSize.s8,
          children: widget.work.tags
              .map(
                (tag) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p12,
                    vertical: AppPadding.p6,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    border: Border.all(
                      color: ColorManager.primary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tag,
                    style: TextStyleManager.getMediumStyle(
                      fontSize: FontSize.s12,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
