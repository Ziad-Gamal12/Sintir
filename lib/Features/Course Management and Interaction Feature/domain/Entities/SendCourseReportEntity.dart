class Sendcoursereportentity {
  final String title;
  String? description;

  Sendcoursereportentity({
    this.description,
    required this.title,
  });
  static List<Sendcoursereportentity> reportReasons = [
    Sendcoursereportentity(title: "محتوى غير لائق"),
    Sendcoursereportentity(title: "معلومات خاطئة"),
    Sendcoursereportentity(title: "عنوان أو وصف مضلل"),
    Sendcoursereportentity(title: "مشكلات تقنية"),
    Sendcoursereportentity(title: "انتهاك حقوق الطبع والنشر"),
    Sendcoursereportentity(title: "محتوى غير ملائم"),
    Sendcoursereportentity(title: "محتوى ذو جودة منخفضة"),
    Sendcoursereportentity(title: "مشكلات تتعلق بالسعر"),
    Sendcoursereportentity(title: "سلوك غير مهني"),
    Sendcoursereportentity(title: "أخرى"),
  ];
}
