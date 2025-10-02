import 'package:sintir/Core/utils/imageAssets.dart';

class Addcoursesectionoptionitem {
  final String title, icon;
  Addcoursesectionoptionitem({required this.title, required this.icon});
  static List<Addcoursesectionoptionitem> toList() {
    return [
      Addcoursesectionoptionitem(
          title: "فديو", icon: Assets.assetsIconsSVGIconsVideoIcon),
      Addcoursesectionoptionitem(
          title: "أمتحان", icon: Assets.assetsIconsSVGIconsExamIcon),
      Addcoursesectionoptionitem(
          title: "ملف", icon: Assets.assetsIconsSVGIconsCustomFileIcon),
    ];
  }
}
