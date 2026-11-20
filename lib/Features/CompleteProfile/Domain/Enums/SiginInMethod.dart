import 'package:sintir/Core/utils/imageAssets.dart';

enum SiginInMethod { google, facebook }

extension SiginInMethodHelper on SiginInMethod {
  String get label {
    switch (this) {
      case SiginInMethod.google:
        return "جوجل";
      case SiginInMethod.facebook:
        return "فيسبوك";
    }
  }

  String get svgIconPath {
    switch (this) {
      case SiginInMethod.google:
        return Assets.assetsIconsSVGIconsGoogle;
      case SiginInMethod.facebook:
        return Assets.assetsIconsSVGIconsFaceBookIcons;
    }
  }

  String get signedInWithText => "تم تسجيل الدخول باستخدام $label";
}
