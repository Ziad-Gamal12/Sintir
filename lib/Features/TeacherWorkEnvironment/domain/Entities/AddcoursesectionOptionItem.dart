import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/locale_keys.dart';

class Addcoursesectionoptionitem {
  final String title, icon;
  Addcoursesectionoptionitem({required this.title, required this.icon});
  static List<Addcoursesectionoptionitem> toList() {
    return [
      Addcoursesectionoptionitem(
          title: LocaleKeys.video, icon: Assets.assetsIconsSVGIconsVideoIcon),
      Addcoursesectionoptionitem(
          title: LocaleKeys.exam, icon: Assets.assetsIconsSVGIconsExamIcon),
      Addcoursesectionoptionitem(
          title: LocaleKeys.file,
          icon: Assets.assetsIconsSVGIconsCustomFileIcon),
    ];
  }
}
