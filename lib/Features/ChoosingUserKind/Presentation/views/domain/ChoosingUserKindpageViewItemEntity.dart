import 'package:localingo/localingo.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/locale_keys.dart';

class ChoosingUserKindpageViewItemEntity {
  final String image, title, description;

  ChoosingUserKindpageViewItemEntity(
      {required this.image, required this.title, required this.description});
  static List<ChoosingUserKindpageViewItemEntity> toList() => [
        ChoosingUserKindpageViewItemEntity(
            image: Assets.assetsIconsSVGIconsChoosingStateStudentIcon,
            title: LocaleKeys.studentRole.tr(),
            description: LocaleKeys.chooseRoleStudent),
        ChoosingUserKindpageViewItemEntity(
          image: Assets.assetsIconsSVGIconsChoosignStateTeacherIcon,
          title: LocaleKeys.teacherRole.tr(),
          description: LocaleKeys.chooseRoleTeacher,
        )
      ];
}
