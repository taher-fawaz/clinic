import 'package:clinic/src/features/home/data/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/res/app_res.dart';

import 'article_card.dart';

class ArticlesSection extends StatelessWidget {
  final List<ArticleModel> articles;
  final VoidCallback? onViewAll;
  final Function(ArticleModel)? onArticleTap;

  const ArticlesSection({
    super.key,
    required this.articles,
    this.onViewAll,
    this.onArticleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorManager.primary.withOpacity(0.1),
                          ColorManager.primary.withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.article_outlined,
                      color: ColorManager.primary,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'المقالات الطبية',
                    style: TextStyleManager.getBoldStyle(
                      fontSize: FontSize.s18,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onViewAll,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorManager.primary.withOpacity(0.1),
                        ColorManager.primary.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: ColorManager.primary.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'عرض الكل',
                        style: TextStyleManager.getSemiBoldStyle(
                          fontSize: FontSize.s14,
                          color: ColorManager.primary,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.arrow_forward,
                        color: ColorManager.primary,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: articles.map((article) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: ArticleCard(
                  article: article,
                  onTap: () => onArticleTap?.call(article),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
