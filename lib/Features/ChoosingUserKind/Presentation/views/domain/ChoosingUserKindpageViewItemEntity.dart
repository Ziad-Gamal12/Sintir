import 'package:sintir/Core/utils/imageAssets.dart';

class ChoosingUserKindpageViewItemEntity {
  final String image, title, description;

  ChoosingUserKindpageViewItemEntity(
      {required this.image, required this.title, required this.description});
  static List<ChoosingUserKindpageViewItemEntity> toList() => [
        ChoosingUserKindpageViewItemEntity(
          image: Assets.assetsIconsSVGIconsChoosingStateStudentIcon,
          title: "طالب",
          description:
              "مرحبًا بك في عالم التعلم والمعرفة!,اكتشف المحتوى المثير وطور مهاراتك.نحن هنا لدعمك في رحلتك التعليمية.ابدأ مغامرتك التعليمية معنا الآن!",
        ),
        ChoosingUserKindpageViewItemEntity(
          image: Assets.assetsIconsSVGIconsChoosignStateTeacherIcon,
          title: "معلم",
          description:
              "مرحبًا بك في منصة التعليم الخاصة بالمعلمين!,نحن هنا لمساعدتك في تحسين تجربة التعليم.,ابدأ بتطوير استراتيجيات تعليمية فعّالة ومبتكرة.,طور مهارات طلابك وكن جزءًا من نجاحهم.",
        )
      ];
}
