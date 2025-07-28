import 'package:clinic/src/features/home/data/models/article_model.dart';
import 'package:clinic/src/features/home/data/models/doctor_work_model.dart';

class MockDataProvider {
  static List<DoctorWorkModel> getDoctorWorks() {
    return [
      DoctorWorkModel(
        id: '1',
        title: 'تبييض الأسنان المتقدم',
        description:
            'علاج تبييض الأسنان المهني الذي حسن من إشراق ابتسامة المريض بشكل ملحوظ وأعطى نتائج طبيعية ومذهلة.',
        beforeImageUrl:
            'https://images.unsplash.com/photo-1606811841689-23dfddce3e95?w=300&h=200&fit=crop',
        afterImageUrl:
            'https://images.unsplash.com/photo-1609840114035-3c981b782dfe?w=300&h=200&fit=crop',
        doctorName: 'د. سارة أحمد',
        specialty: 'أخصائية تقويم الأسنان',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        tags: ['تبييض', 'تجميل'],
      ),
      DoctorWorkModel(
        id: '2',
        title: 'زراعة الأسنان الناجحة',
        description:
            'عملية زراعة أسنان كاملة مع شفاء ممتاز ومظهر طبيعي، استعادة الوظيفة الكاملة للفم والثقة في الابتسامة.',
        beforeImageUrl:
            'https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=300&h=200&fit=crop',
        afterImageUrl:
            'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=200&fit=crop',
        doctorName: 'د. محمد علي',
        specialty: 'جراح الفم والأسنان',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        tags: ['زراعة', 'ترميم'],
      ),
      DoctorWorkModel(
        id: '3',
        title: 'تجميل الابتسامة الشامل',
        description:
            'تحويل كامل للابتسامة باستخدام القشور التجميلية والتبييض المهني، نتائج طبيعية ومتناسقة مع ملامح الوجه.',
        beforeImageUrl:
            'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=300&h=200&fit=crop',
        afterImageUrl:
            'https://images.unsplash.com/photo-1606811971618-4486d14f3f99?w=300&h=200&fit=crop',
        doctorName: 'د. فاطمة حسن',
        specialty: 'طبيبة أسنان تجميلية',
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        tags: ['تجميل', 'قشور'],
      ),
      DoctorWorkModel(
        id: '4',
        title: 'علاج جذور الأسنان',
        description:
            'علاج جذور متقدم أنقذ السن من الخلع وحافظ على الوظيفة الطبيعية مع تخفيف الألم بشكل كامل.',
        beforeImageUrl:
            'https://images.unsplash.com/photo-1606811971618-4486d14f3f99?w=300&h=200&fit=crop',
        afterImageUrl:
            'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=300&h=200&fit=crop',
        doctorName: 'د. أحمد الطيب',
        specialty: 'أخصائي علاج الجذور',
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
        tags: ['جذور', 'علاج'],
      ),
    ];
  }

  static List<ArticleModel> getArticles() {
    return [
      ArticleModel(
        id: '1',
        title: 'أهمية الفحص الدوري للأسنان',
        shortDescription:
            'تعرف على أهمية زيارات طبيب الأسنان المنتظمة للحفاظ على صحة الفم المثلى ومنع مشاكل الأسنان الخطيرة والمضاعفات المستقبلية.',
        content: 'محتوى المقال الكامل هنا...',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1606811841689-23dfddce3e95?w=400&h=250&fit=crop',
        authorName: 'د. أحمد محمود',
        authorImageUrl:
            'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=50&h=50&fit=crop&crop=face',
        publishedAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        tags: ['الرعاية الوقائية', 'صحة الفم', 'نصائح طبية'],
        readTimeMinutes: 5,
        isFeatured: true,
      ),
      ArticleModel(
        id: '2',
        title: 'دليل شامل لزراعة الأسنان',
        shortDescription:
            'كل ما تحتاج لمعرفته عن زراعة الأسنان، من الإجراء إلى التعافي والرعاية طويلة المدى، مع نصائح مهمة للنجاح.',
        content: 'محتوى المقال الكامل هنا...',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=400&h=250&fit=crop',
        authorName: 'د. مريم عبدالله',
        authorImageUrl:
            'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=50&h=50&fit=crop&crop=face',
        publishedAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 4)),
        tags: ['زراعة الأسنان', 'جراحة', 'ترميم'],
        readTimeMinutes: 8,
        isFeatured: false,
      ),
      ArticleModel(
        id: '3',
        title: 'العناية بالأسنان في رمضان',
        shortDescription:
            'نصائح مهمة للحفاظ على صحة الأسنان واللثة خلال شهر رمضان المبارك، مع إرشادات للصيام وتنظيف الأسنان.',
        content: 'محتوى المقال الكامل هنا...',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=250&fit=crop',
        authorName: 'د. خالد الشريف',
        authorImageUrl:
            'https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=50&h=50&fit=crop&crop=face',
        publishedAt: DateTime.now().subtract(const Duration(days: 12)),
        updatedAt: DateTime.now().subtract(const Duration(days: 11)),
        tags: ['رمضان', 'العناية', 'نصائح'],
        readTimeMinutes: 6,
        isFeatured: true,
      ),
      ArticleModel(
        id: '4',
        title: 'تقويم الأسنان للبالغين',
        shortDescription:
            'دليل شامل لتقويم الأسنان للبالغين، الخيارات المتاحة والنتائج المتوقعة مع نصائح للعناية أثناء فترة العلاج.',
        content: 'محتوى المقال الكامل هنا...',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1609840114035-3c981b782dfe?w=400&h=250&fit=crop',
        authorName: 'د. ليلى حسن',
        authorImageUrl:
            'https://images.unsplash.com/photo-1594824475317-8b7b0c8b6b6e?w=50&h=50&fit=crop&crop=face',
        publishedAt: DateTime.now().subtract(const Duration(days: 18)),
        updatedAt: DateTime.now().subtract(const Duration(days: 17)),
        tags: ['تقويم', 'بالغين', 'علاج'],
        readTimeMinutes: 7,
        isFeatured: false,
      ),
    ];
  }
}
