import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/res/app_res.dart';
import '../../data/models/article_model.dart';

class ArticleContent extends StatelessWidget {
  final ArticleModel article;

  const ArticleContent({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorManager.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Article Tags
          if (article.tags.isNotEmpty) ..._buildTags(),

          // Article Short Description
          if (article.shortDescription.isNotEmpty) ..._buildShortDescription(),

          // Article Content
          ..._buildContent(),

          SizedBox(height: 32.h),

          // Article Footer with Author Info
          _buildArticleFooter(),
        ],
      ),
    );
  }

  List<Widget> _buildTags() {
    return [
      Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: article.tags.map((tag) {
          return Container(
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
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: ColorManager.primary.withOpacity(0.2),
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
          );
        }).toList(),
      ),
      SizedBox(height: 24.h),
    ];
  }

  List<Widget> _buildShortDescription() {
    return [
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorManager.backgroundSecondary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: ColorManager.primary.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 4.w,
              height: 60.h,
              decoration: BoxDecoration(
                gradient: ColorManager.primaryGradient,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                article.shortDescription,
                style: TextStyleManager.getMediumStyle(
                  fontSize: FontSize.s16,
                  color: ColorManager.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 24.h),
    ];
  }

  List<Widget> _buildContent() {
    // Split content into paragraphs
    final paragraphs = article.content
        .split('\n\n')
        .where((p) => p.trim().isNotEmpty)
        .toList();

    return paragraphs.map((paragraph) {
      return Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Text(
          paragraph.trim(),
          style: TextStyleManager.getRegularStyle(
            fontSize: FontSize.s16,
            color: ColorManager.textPrimary,
          ),
          textAlign: TextAlign.justify,
        ),
      );
    }).toList();
  }

  Widget _buildArticleFooter() {
    return Container(
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
          Text(
            'عن الكاتب',
            style: TextStyleManager.getBoldStyle(
              fontSize: FontSize.s18,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              // Author Avatar
              Container(
                width: 60.w,
                height: 60.h,
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: ColorManager.primaryGradient,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.surface,
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
                            size: 30.sp,
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
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.authorName,
                      style: TextStyleManager.getBoldStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'كاتب طبي متخصص في طب الأسنان',
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
          SizedBox(height: 16.h),
          // Article Meta Info
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: ColorManager.surface,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: ColorManager.border,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetaItem(
                  icon: Icons.access_time,
                  label: 'وقت القراءة',
                  value: '${article.readTimeMinutes} دقائق',
                ),
                Container(
                  width: 1,
                  height: 30.h,
                  color: ColorManager.border,
                ),
                _buildMetaItem(
                  icon: Icons.calendar_today,
                  label: 'تاريخ النشر',
                  value: _formatDate(article.publishedAt),
                ),
                Container(
                  width: 1,
                  height: 30.h,
                  color: ColorManager.border,
                ),
                _buildMetaItem(
                  icon: Icons.update,
                  label: 'آخر تحديث',
                  value: _formatDate(article.updatedAt),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20.sp,
          color: ColorManager.primary,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyleManager.getRegularStyle(
            fontSize: FontSize.s10,
            color: ColorManager.textSecondary,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s12,
            color: ColorManager.textPrimary,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
