import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/res/app_res.dart';
import '../../data/models/article_model.dart';
import '../../data/mock_data_provider.dart';
import '../widgets/article_card.dart';
import 'article_details_screen.dart';

class DoctorArticlesScreen extends StatefulWidget {
  const DoctorArticlesScreen({super.key});

  @override
  State<DoctorArticlesScreen> createState() => _DoctorArticlesScreenState();
}

class _DoctorArticlesScreenState extends State<DoctorArticlesScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  List<ArticleModel> articles = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadArticles();
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

  Future<void> _loadArticles() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      final loadedArticles = MockDataProvider.getArticles();

      setState(() {
        articles = loadedArticles;
        isLoading = false;
      });

      _animationController.forward();
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'articles.loadingError'.tr();
      });
    }
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
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120.h,
      floating: false,
      pinned: true,
      backgroundColor: ColorManager.primary,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'articles.title'.tr(),
          style: TextStyleManager.getBoldStyle(
            fontSize: FontSize.s20,
            color: Colors.white,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: ColorManager.primaryGradient,
          ),
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 20.sp,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return _buildLoadingState();
    }

    if (errorMessage != null) {
      return _buildErrorState();
    }

    if (articles.isEmpty) {
      return _buildEmptyState();
    }

    return _buildArticlesList();
  }

  Widget _buildLoadingState() {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ColorManager.primary),
            ),
            SizedBox(height: 16.h),
            Text(
              'articles.loading'.tr(),
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s16,
                color: ColorManager.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64.sp,
                color: ColorManager.error,
              ),
              SizedBox(height: 16.h),
              Text(
                errorMessage!,
                style: TextStyleManager.getMediumStyle(
                  fontSize: FontSize.s16,
                  color: ColorManager.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: _loadArticles,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'articles.retry'.tr(),
                  style: TextStyleManager.getMediumStyle(
                    fontSize: FontSize.s14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.article_outlined,
                size: 64.sp,
                color: ColorManager.textSecondary,
              ),
              SizedBox(height: 16.h),
              Text(
                'articles.noResults'.tr(),
                style: TextStyleManager.getMediumStyle(
                  fontSize: FontSize.s16,
                  color: ColorManager.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'articles.noResultsSubtitle'.tr(),
                style: TextStyleManager.getRegularStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticlesList() {
    return SliverPadding(
      padding: EdgeInsets.all(20.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final article = articles[index];
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: ArticleCard(
                    article: article,
                    onTap: () => _navigateToArticleDetails(article),
                  ),
                ),
              ),
            );
          },
          childCount: articles.length,
        ),
      ),
    );
  }

  void _navigateToArticleDetails(ArticleModel article) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ArticleDetailsScreen(article: article);
        },
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
