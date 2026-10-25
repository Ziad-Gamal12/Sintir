// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(count) => "${count} courses";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "check_payment_status": MessageLookupByLibrary.simpleMessage(
      "Check payment status",
    ),
    "checkout_expired": MessageLookupByLibrary.simpleMessage(
      "This checkout has expired.",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Copy"),
    "copy_failed": MessageLookupByLibrary.simpleMessage(
      "Could not copy the student ID",
    ),
    "courses_count": m0,
    "education_level": MessageLookupByLibrary.simpleMessage("Education level"),
    "exam_results_history": MessageLookupByLibrary.simpleMessage(
      "Exam results history",
    ),
    "exam_score_progression": MessageLookupByLibrary.simpleMessage(
      "Exam score progression",
    ),
    "highest_score": MessageLookupByLibrary.simpleMessage("Highest score"),
    "leave_checkout": MessageLookupByLibrary.simpleMessage("Leave checkout"),
    "lowest_score": MessageLookupByLibrary.simpleMessage("Lowest score"),
    "payment_not_completed": MessageLookupByLibrary.simpleMessage(
      "Payment was not completed.",
    ),
    "payment_requires_review": MessageLookupByLibrary.simpleMessage(
      "Paymob confirmed a payment, but we could not finalize enrollment automatically. Contact support before paying again.",
    ),
    "payment_status_unavailable": MessageLookupByLibrary.simpleMessage(
      "Payment status could not be retrieved. Try again.",
    ),
    "payment_verifying": MessageLookupByLibrary.simpleMessage(
      "Payment is being verified. You can safely leave this page and check again later.",
    ),
    "performance_trend": MessageLookupByLibrary.simpleMessage("Average score"),
    "student_code": MessageLookupByLibrary.simpleMessage("Student ID:"),
    "subscribed_courses": MessageLookupByLibrary.simpleMessage(
      "Subscribed courses",
    ),
    "subscriber_address_fallback": MessageLookupByLibrary.simpleMessage(
      "Address not specified",
    ),
    "subscriber_details_title": MessageLookupByLibrary.simpleMessage(
      "Subscriber Details",
    ),
    "subscriber_education_fallback": MessageLookupByLibrary.simpleMessage(
      "Education level not specified",
    ),
    "subscriber_id_copied": MessageLookupByLibrary.simpleMessage(
      "Student ID copied",
    ),
    "subscriber_joined_date": MessageLookupByLibrary.simpleMessage("Joined"),
    "subscriber_phone_fallback": MessageLookupByLibrary.simpleMessage(
      "Phone number not available",
    ),
  };
}
