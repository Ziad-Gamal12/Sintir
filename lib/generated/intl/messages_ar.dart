// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(count) => "${count} كورس";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "check_payment_status": MessageLookupByLibrary.simpleMessage(
      "تحقق من حالة الدفع",
    ),
    "checkout_expired": MessageLookupByLibrary.simpleMessage(
      "انتهت صلاحية عملية الدفع.",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("نسخ"),
    "copy_failed": MessageLookupByLibrary.simpleMessage("تعذر نسخ كود الطالب"),
    "courses_count": m0,
    "education_level": MessageLookupByLibrary.simpleMessage("المستوى الدراسي"),
    "exam_results_history": MessageLookupByLibrary.simpleMessage(
      "سجل نتائج الاختبارات",
    ),
    "exam_score_progression": MessageLookupByLibrary.simpleMessage(
      "تطور درجات الاختبارات",
    ),
    "highest_score": MessageLookupByLibrary.simpleMessage("أعلى الدرجات"),
    "leave_checkout": MessageLookupByLibrary.simpleMessage("مغادرة الدفع"),
    "lowest_score": MessageLookupByLibrary.simpleMessage("أدنى نتيجة"),
    "payment_not_completed": MessageLookupByLibrary.simpleMessage(
      "لم تكتمل عملية الدفع.",
    ),
    "payment_requires_review": MessageLookupByLibrary.simpleMessage(
      "أكدت Paymob الدفع، لكن تعذر إتمام التسجيل تلقائيًا. تواصل مع الدعم قبل الدفع مرة أخرى.",
    ),
    "payment_status_unavailable": MessageLookupByLibrary.simpleMessage(
      "تعذر استرجاع حالة الدفع. حاول مرة أخرى.",
    ),
    "payment_verifying": MessageLookupByLibrary.simpleMessage(
      "جارٍ التحقق من الدفع. يمكنك مغادرة هذه الصفحة والعودة للتحقق لاحقًا.",
    ),
    "performance_trend": MessageLookupByLibrary.simpleMessage("متوسط النتائج"),
    "student_code": MessageLookupByLibrary.simpleMessage("كود الطالب:"),
    "subscribed_courses": MessageLookupByLibrary.simpleMessage(
      "اشتراكات الطالب",
    ),
    "subscriber_address_fallback": MessageLookupByLibrary.simpleMessage(
      "العنوان غير محدد",
    ),
    "subscriber_details_title": MessageLookupByLibrary.simpleMessage(
      "تفاصيل المشترك",
    ),
    "subscriber_education_fallback": MessageLookupByLibrary.simpleMessage(
      "المستوى الدراسي غير محدد",
    ),
    "subscriber_id_copied": MessageLookupByLibrary.simpleMessage(
      "تم نسخ كود الطالب",
    ),
    "subscriber_joined_date": MessageLookupByLibrary.simpleMessage(
      "تاريخ الانضمام",
    ),
    "subscriber_phone_fallback": MessageLookupByLibrary.simpleMessage(
      "رقم الهاتف غير متاح",
    ),
  };
}
