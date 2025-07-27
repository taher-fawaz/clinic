import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/res/app_res.dart';
import '../../data/models/article_model.dart';

class ArticleCard extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback? onTap;

  const ArticleCard({
    super.key,
    required this.article,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: ColorManager.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              child: Image.network(
                article.thumbnailUrl,
                height: 180.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorManager.backgroundSecondary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.article_outlined,
                        size: 40.sp,
                        color: ColorManager.textSecondary,
                      ),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 180.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorManager.backgroundSecondary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        color: ColorManager.primary,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Article Content
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured Badge
                  if (article.isFeatured)
                    Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.secondary,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Featured',
                        style: TextStyleManager.getMediumStyle(
                          fontSize: FontSize.s10,
                          color: ColorManager.onSecondary,
                        ),
                      ),
                    ),
                  // Article Title
                  Text(
                    article.title,
                    style: TextStyleManager.getSemiBoldStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  // Article Description
                  Text(
                    article.shortDescription,
                    style: TextStyleManager.getRegularStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.textSecondary,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12.h),
                  // Article Meta Information
                  Row(
                    children: [
                      // Author Avatar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Image.network(
                          article.authorImageUrl,
                          width: 32.w,
                          height: 32.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorManager.backgroundSecondary,
                              ),
                              child: Icon(
                                Icons.person_outline,
                                size: 16.sp,
                                color: ColorManager.textSecondary,
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorManager.backgroundSecondary,
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 16.w,
                                  height: 16.h,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Author Name and Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.authorName,
                              style: TextStyleManager.getMediumStyle(
                                fontSize: FontSize.s12,
                                color: ColorManager.textPrimary,
                              ),
                            ),
                            Text(
                              _formatDate(article.publishedAt),
                              style: TextStyleManager.getRegularStyle(
                                fontSize: FontSize.s10,
                                color: ColorManager.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Read Time
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.backgroundSecondary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '${article.readTimeMinutes} ${'home.articles.minRead'.tr()}',
                          style: TextStyleManager.getRegularStyle(
                            fontSize: FontSize.s10,
                            color: ColorManager.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Tags
                  if (article.tags.isNotEmpty)
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 4.h,
                      children: article.tags.take(3).map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorManager.primaryLight.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: ColorManager.primaryLight.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            tag,
                            style: TextStyleManager.getRegularStyle(
                              fontSize: FontSize.s10,
                              color: ColorManager.primary,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  SizedBox(height: 12.h),
                  // Read More Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'home.articles.readMore'.tr(),
                      style: TextStyleManager.getMediumStyle(
                        fontSize: FontSize.s14,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }
}