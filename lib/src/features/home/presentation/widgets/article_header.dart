import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/res/app_res.dart';
import '../../data/models/article_model.dart';

class ArticleHeader extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback? onBackPressed;

  const ArticleHeader({
    super.key,
    required this.article,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.h,
      floating: false,
      pinned: true,
      backgroundColor: ColorManager.surface,
      leading: Container(
        margin: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.5),
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20.sp,
          ),
          onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Article Image
            Image.network(
              article.thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: ColorManager.backgroundSecondary,
                  child: Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 60.sp,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: ColorManager.backgroundSecondary,
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
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            // Article Info Overlay
            Positioned(
              bottom: 20.h,
              left: 20.w,
              right: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Featured Badge
                  if (article.isFeatured)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorManager.warning,
                            ColorManager.warning.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.warning.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: 14.sp,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'مميز',
                            style: TextStyleManager.getSemiBoldStyle(
                              fontSize: FontSize.s12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (article.isFeatured) SizedBox(height: 12.h),
                  // Article Title
                  Text(
                    article.title,
                    style: TextStyleManager.getBoldStyle(
                      fontSize: FontSize.s24,
                      color: Colors.white,
                      height: 1.3,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12.h),
                  // Author and Meta Info
                  Row(
                    children: [
                      // Author Avatar
                      Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            article.authorImageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: ColorManager.backgroundSecondary,
                                child: Icon(
                                  Icons.person,
                                  color: ColorManager.textSecondary,
                                  size: 20.sp,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.authorName,
                              style: TextStyleManager.getSemiBoldStyle(
                                fontSize: FontSize.s14,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Row(
                              children: [
                                Text(
                                  _formatDate(article.publishedAt),
                                  style: TextStyleManager.getRegularStyle(
                                    fontSize: FontSize.s12,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                                Text(
                                  ' • ',
                                  style: TextStyleManager.getRegularStyle(
                                    fontSize: FontSize.s12,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                                Text(
                                  '${article.readTimeMinutes} دقائق قراءة',
                                  style: TextStyleManager.getRegularStyle(
                                    fontSize: FontSize.s12,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
      return 'اليوم';
    } else if (difference.inDays == 1) {
      return 'أمس';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} أيام';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? 'منذ أسبوع' : 'منذ $weeks أسابيع';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }
}
