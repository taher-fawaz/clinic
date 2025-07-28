import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinic/src/core/res/app_res.dart';
import 'package:clinic/src/features/home/data/models/doctor_work_model.dart';
import 'package:clinic/src/features/home/data/mock_data_provider.dart';
import 'package:clinic/src/features/doctor_works/presentation/widgets/doctor_work_card.dart';
import 'package:clinic/src/features/doctor_works/presentation/pages/doctor_work_detail_screen.dart';

class DoctorWorkShowcaseScreen extends StatefulWidget {
  const DoctorWorkShowcaseScreen({super.key});

  @override
  State<DoctorWorkShowcaseScreen> createState() => _DoctorWorkShowcaseScreenState();
}

class _DoctorWorkShowcaseScreenState extends State<DoctorWorkShowcaseScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  List<DoctorWorkModel> _doctorWorks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadDoctorWorks();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
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
  }

  Future<void> _loadDoctorWorks() async {
    // Simulate loading delay for smooth animation
    await Future.delayed(const Duration(milliseconds: 300));
    
    setState(() {
      _doctorWorks = MockDataProvider.getDoctorWorks();
      _isLoading = false;
    });
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundPrimary,
      appBar: _buildAppBar(),
      body: _isLoading ? _buildLoadingState() : _buildContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: ColorManager.backgroundPrimary,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: ColorManager.textPrimary,
          size: 20,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'doctorWorks.title'.tr(),
        style: TextStyleManager.getBoldStyle(
          fontSize: FontSize.s18,
          color: ColorManager.textPrimary,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorManager.primary),
          ),
          const SizedBox(height: AppMargin.m16),
          Text(
            'common.loading'.tr(),
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: CustomScrollView(
          slivers: [
            _buildHeader(),
            _buildWorksGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'doctorWorks.subtitle'.tr(),
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s14,
                color: ColorManager.textSecondary,
              ),
            ),
            const SizedBox(height: AppSize.s8),
            Text(
              'doctorWorks.description'.tr(),
              style: TextStyleManager.getMediumStyle(
                fontSize: FontSize.s16,
                color: ColorManager.textPrimary,
              ),
            ),
            const SizedBox(height: AppSize.s16),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p12,
                vertical: AppPadding.p8,
              ),
              decoration: BoxDecoration(
                color: ColorManager.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSize.s20),
              ),
              child: Text(
                '${_doctorWorks.length} ${'doctorWorks.cases'.tr()}',
                style: TextStyleManager.getMediumStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorksGrid() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: AppSize.s12,
          mainAxisSpacing: AppSize.s16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final work = _doctorWorks[index];
            return AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                final delay = index * 0.1;
                final animationValue = Curves.easeOutCubic.transform(
                  (_animationController.value - delay).clamp(0.0, 1.0),
                );
                
                return Transform.translate(
                  offset: Offset(0, 50 * (1 - animationValue)),
                  child: Opacity(
                    opacity: animationValue,
                    child: DoctorWorkCard(
                      work: work,
                      onTap: () => _navigateToDetail(work),
                    ),
                  ),
                );
              },
            );
          },
          childCount: _doctorWorks.length,
        ),
      ),
    );
  }

  void _navigateToDetail(DoctorWorkModel work) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DoctorWorkDetailScreen(work: work),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          
          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}