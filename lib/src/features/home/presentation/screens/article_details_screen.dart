import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/article_model.dart';
import '../widgets/article_content.dart';
import '../widgets/article_header.dart';
import '../../../../core/res/app_res.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final ArticleModel article;

  const ArticleDetailsScreen({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundPrimary,
      body: CustomScrollView(
        slivers: [
          // Article Header with image, title, and back button
          ArticleHeader(article: article),

          // Article Content
          SliverToBoxAdapter(
            child: ArticleContent(article: article),
          ),

          // Related Articles Section (Optional)
          SliverToBoxAdapter(
            child: _buildRelatedArticlesSection(context),
          ),

          // Bottom spacing
          SliverToBoxAdapter(
            child: SizedBox(height: 32.h),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedArticlesSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorManager.backgroundSecondary.withOpacity(0.3),
            ColorManager.backgroundSecondary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorManager.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  gradient: ColorManager.primaryGradient,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.article_outlined,
                  color: ColorManager.surface,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'مقالات ذات صلة',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: ColorManager.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: ColorManager.border,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: ColorManager.primary,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'ستتم إضافة المقالات ذات الصلة قريباً لتوفير تجربة قراءة أفضل.',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorManager.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ).copyWith(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: ColorManager.primaryGradient,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: ColorManager.surface,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'العودة للمقالات',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.surface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
