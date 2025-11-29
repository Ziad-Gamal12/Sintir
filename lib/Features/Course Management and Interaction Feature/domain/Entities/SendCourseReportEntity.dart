import 'package:sintir/locale_keys.dart';

class Sendcoursereportentity {
  final String title;
  String? description;

  Sendcoursereportentity({
    this.description,
    required this.title,
  });
  static List<Sendcoursereportentity> reportReasons = [
    Sendcoursereportentity(title: LocaleKeys.reportInappropriate),
    Sendcoursereportentity(title: LocaleKeys.reportWrongInfo),
    Sendcoursereportentity(title: LocaleKeys.reportMisleading),
    Sendcoursereportentity(title: LocaleKeys.reportTechnicalIssue),
    Sendcoursereportentity(title: LocaleKeys.reportCopyright),
    Sendcoursereportentity(title: LocaleKeys.reportUnfit),
    Sendcoursereportentity(title: LocaleKeys.reportLowQuality),
    Sendcoursereportentity(title: LocaleKeys.reportPriceIssue),
    Sendcoursereportentity(title: LocaleKeys.reportUnprofessional),
    Sendcoursereportentity(title: LocaleKeys.reportOther),
  ];
}
