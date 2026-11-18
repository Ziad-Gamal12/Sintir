import 'package:sintir/locale_keys.dart';

const int maxCourseFeedbackLength = 500;

String courseFeedbackErrorMessage(String code) {
  switch (code) {
    case 'not_subscribed':
      return LocaleKeys.ratingErrorNotSubscribed;
    case 'own_course':
    case 'not_student':
      return LocaleKeys.ratingErrorNotAllowed;
    case 'inactive_user':
      return LocaleKeys.ratingErrorInactiveAccount;
    case 'course_unavailable':
      return LocaleKeys.ratingErrorCourseUnavailable;
    case 'too_many_requests':
      return LocaleKeys.ratingErrorTooFast;
    case 'busy':
      return LocaleKeys.ratingErrorBusy;
    case 'invalid_rating':
      return LocaleKeys.ratingRequired;
    case 'text_too_long':
      return LocaleKeys.ratingErrorTextTooLong;
    case 'feedback_not_found':
      return LocaleKeys.ratingErrorAlreadyDeleted;
    case 'unauthorized':
    case 'authentication_required':
      return LocaleKeys.ratingErrorSignIn;
    case 'network_error':
      return LocaleKeys.serverConnectionError;
    case 'network_timeout':
      return LocaleKeys.connectionTimeout;
    default:
      return LocaleKeys.errorOccurredMessage;
  }
}
