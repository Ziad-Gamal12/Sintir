// lib/locale_keys.dart
// Auto-generated file. Do not edit manually.

import 'package:localingo/localingo.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';

/// Type-safe translation keys
/// Usage: Text(LocaleKeys.appName)
class LocaleKeys {
  static String resultsJoined(String date) =>
      'results_joined'.tr(args: {'date': date});
  static String resultsStudentName(String name) =>
      'results_student_name'.tr(args: {'name': name});
  static String resultsCode(String code) =>
      'results_code'.tr(args: {'code': code});
  static String resultsAssessmentFallback(String code) =>
      'results_assessment_fallback'.tr(args: {'code': code});
  static String get resultsGeneralAverage => 'results_general_average'.tr();
  static String get resultsAverageSubtitle => 'results_average_subtitle'.tr();
  static String get resultsAverage => 'results_average'.tr();
  static String resultsRecordedCountValue(int count, String locale) =>
      Intl.plural(
        count,
        locale: locale,
        zero: 'results_count_zero'.tr(),
        one: 'results_count_one'.tr(
          args: {'count': LocaleFormatter.number(count, locale)},
        ),
        two: 'results_count_two'.tr(
          args: {'count': LocaleFormatter.number(count, locale)},
        ),
        few: 'results_count_few'.tr(
          args: {'count': LocaleFormatter.number(count, locale)},
        ),
        many: 'results_count_many'.tr(
          args: {'count': LocaleFormatter.number(count, locale)},
        ),
        other: 'results_count_other'.tr(
          args: {'count': LocaleFormatter.number(count, locale)},
        ),
      );
  static String get resultsExcellent => 'results_excellent'.tr();
  static String get passed => 'passed'.tr();
  static String get failed => 'failed'.tr();
  static String get correctAnswers => 'correct_answers'.tr();
  static String get submittedAt => 'submitted_at'.tr();
  static String submittedAtWithDate(String date) =>
      'submitted_at_with_date'.tr(args: {'date': date});
  static String get deleteItemTitle => 'delete_item_title'.tr();
  static String get cannotBeUndone => 'cannot_be_undone'.tr();
  static String get resultsGood => 'results_good'.tr();
  static String get resultsSteady => 'results_steady'.tr();
  static String get resultsFollowUp => 'results_follow_up'.tr();
  static String get resultsTimelineTitle => 'results_timeline_title'.tr();
  static String get resultsAcademicTerm => 'results_academic_term'.tr();
  static String get resultsFullyComplete => 'results_fully_complete'.tr();
  static String get resultsPartiallyComplete =>
      'results_partially_complete'.tr();
  static String get resultsRecorded => 'results_recorded'.tr();
  static String get resultsEarnedScore => 'results_earned_score'.tr();
  static String resultsQuestionValue(int earned, int total, String locale) {
    final args = {
      'earned': LocaleFormatter.number(earned, locale),
      'total': LocaleFormatter.number(total, locale),
    };
    return Intl.plural(
      total,
      locale: locale,
      one: 'results_question_one'.tr(args: args),
      two: 'results_question_two'.tr(args: args),
      few: 'results_question_few'.tr(args: args),
      many: 'results_question_many'.tr(args: args),
      other: 'results_question_other'.tr(args: args),
    );
  }

  static String get resultsAttemptDate => 'results_attempt_date'.tr();
  static String get resultsFooterNote => 'results_footer_note'.tr();
  static String get resultsPassed => 'results_passed'.tr();
  static String get resultsNotPassed => 'results_not_passed'.tr();
  static String get resultsAllLoaded => 'results_all_loaded'.tr();
  static String get resultsBack => 'results_back'.tr();

  static String get resultsBrandLine => 'results_brand_line'.tr();
  static String get resultsEmptyTitle => 'results_empty_title'.tr();
  static String get resultsEmptyHint => 'results_empty_hint'.tr();
  static String get resultsRetry => 'results_retry'.tr();
  static String get resultsErrorTitle => 'results_error_title'.tr();
  static String resultsGaugeSemantics(String value) =>
      'results_gauge_semantics'.tr(args: {'value': value});
  static String resultsAssessmentSemantics(String value) =>
      'results_assessment_semantics'.tr(args: {'value': value});
  static String get paymentVerifying => 'payment_verifying'.tr();
  static String get paymentNotCompleted => 'payment_not_completed'.tr();
  static String get checkoutExpired => 'checkout_expired'.tr();
  static String get paymentStatusUnavailable =>
      'payment_status_unavailable'.tr();
  static String paymentCheckCooldown(int seconds) {
    final prefix = 'payment_check_cooldown_prefix'.tr();
    final suffix = 'payment_check_cooldown_suffix'.tr();
    return '$prefix $seconds $suffix';
  }

  static String get paymentFinalizingEnrollment =>
      'payment_finalizing_enrollment'.tr();
  static String get paymentRequiresReview => 'payment_requires_review'.tr();
  static String get retryCheckout => 'retry_checkout'.tr();
  static String get checkPaymentStatus => 'check_payment_status'.tr();
  static String get leaveCheckout => 'leave_checkout'.tr();
  static String get existingCheckoutTitle => 'existing_checkout_title'.tr();
  static String get existingCheckoutMessage => 'existing_checkout_message'.tr();
  static String get existingCheckoutLaterMessage =>
      'existing_checkout_later_message'.tr();
  static String get paymentPending => 'payment_pending'.tr();
  static String get paymentVerificationInProgress =>
      'payment_verification_in_progress'.tr();
  static String get paymentCheckingStatus => 'payment_checking_status'.tr();
  static String get paymentConfirmedHeading => 'payment_confirmed_heading'.tr();
  static String get paymentConfirmedMessage => 'payment_confirmed_message'.tr();
  static String get paymentConfirmedAmount => 'payment_confirmed_amount'.tr();
  static String get paymentDiscount => 'payment_discount'.tr();
  static String get returnToCourse => 'return_to_course'.tr();
  static String get paymentStatusTitle => 'payment_status_title'.tr();
  static String get existingCheckoutCouponMismatch =>
      'existing_checkout_coupon_mismatch'.tr();
  static String get originalCheckoutAmount => 'original_checkout_amount'.tr();
  static String get originalCheckoutCoupon => 'original_checkout_coupon'.tr();
  static String get noCouponApplied => 'no_coupon_applied'.tr();
  static String get resumeCheckout => 'resume_checkout'.tr();
  static String get checkLater => 'check_later'.tr();
  static String get subscriberDetailsTitle => 'subscriber_details_title'.tr();
  static String get subscriberEducationFallback =>
      'subscriber_education_fallback'.tr();
  static String get subscriberAddressFallback =>
      'subscriber_address_fallback'.tr();
  static String get subscriberPhoneFallback => 'subscriber_phone_fallback'.tr();
  static String get subscriberJoinedDate => 'subscriber_joined_date'.tr();
  static String get studentCode => 'student_code'.tr();
  static String get subscriberIdCopied => 'subscriber_id_copied'.tr();
  static String get copy => 'copy'.tr();
  static String get copyFailed => 'copy_failed'.tr();
  static String get subscribedCourses => 'subscribed_courses'.tr();
  static String coursesCount(int count) =>
      'courses_count'.tr(args: {'count': '$count'});
  static String get subscriberSubscriptionsTitle =>
      'subscriber_subscriptions_title'.tr();
  static String subscriberTrendImprovingFor(int percent, String locale) =>
      'subscriber_trend_improving'.tr(
        args: {'percent': LocaleFormatter.number(percent, locale)},
      );
  static String subscriberTrendDecliningFor(int percent, String locale) =>
      'subscriber_trend_declining'.tr(
        args: {'percent': LocaleFormatter.number(percent, locale)},
      );
  static String get subscriberTrendStable => 'subscriber_trend_stable'.tr();
  static String subscriberTrendSemantics(String trend) =>
      'subscriber_trend_semantics'.tr(args: {'trend': trend});
  static String get subscriberChartNeedsTwo =>
      'subscriber_chart_needs_two'.tr();
  static String subscriberChartTooltip(int attempt, int score, String locale) =>
      'subscriber_chart_tooltip'.tr(
        args: {
          'attempt': LocaleFormatter.number(attempt, locale),
          'score': LocaleFormatter.number(score, locale),
        },
      );
  static String subscriberChartSemantics(
    int count,
    int first,
    int latest,
    String trend,
    String locale,
  ) => 'subscriber_chart_semantics'.tr(
    args: {
      'count': LocaleFormatter.number(count, locale),
      'first': LocaleFormatter.number(first, locale),
      'latest': LocaleFormatter.number(latest, locale),
      'trend': trend,
    },
  );
  static String get subscriberAttempt => 'subscriber_attempt'.tr();
  static String get subscriberHighestResult => 'subscriber_highest_result'.tr();
  static String get subscriberAverage => 'subscriber_average'.tr();
  static String get subscriberLowestResult => 'subscriber_lowest_result'.tr();
  static String subscriberCourseCount(int count, String locale) => Intl.plural(
    count,
    locale: locale,
    zero: 'subscriber_courses_zero'.tr(),
    one: 'subscriber_courses_one'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    two: 'subscriber_courses_two'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    few: 'subscriber_courses_few'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    many: 'subscriber_courses_many'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    other: 'subscriber_courses_other'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
  );
  static String get performanceTrend => 'performance_trend'.tr();
  static String get examScoreProgression => 'exam_score_progression'.tr();
  static String get examResultsHistory => 'exam_results_history'.tr();
  static String get educationLevel => 'education_level'.tr();
  static String get welcomeTo => 'welcome_to'.tr();
  static String get description1 => 'description_1'.tr();
  static String get learnEasySafe => 'learn_easy_safe'.tr();
  static String get description2 => 'description_2'.tr();
  static String get myMistakesTitle => 'app_bar_title'.tr();
  static String get createOwnExam => 'create_own_exam'.tr();
  static String get selectSubject => 'select_subject'.tr();
  static String get questionCount => 'question_count'.tr();
  static String get questionsLabel => 'questions_label'.tr();
  static String get noteTitle => 'note_title'.tr();
  static String get noteBody => 'note_body'.tr();
  static String get myMistakesstatusActive => 'mistake_status_active'.tr();
  static String get statusImproving => 'status_improving'.tr();
  static String get statusMastered => 'status_mastered'.tr();
  static String get yourAnswer => 'your_answer'.tr();
  static String get correctAnswer => 'correct_answer'.tr();
  static String get totalMistakes => 'total_mistakes'.tr();
  static String get arabic => 'Arabic'.tr();
  static String get english => 'English'.tr();
  static String get french => 'French'.tr();
  static String get italian => 'Italian'.tr();
  static String get spanish => 'Spanish'.tr();
  static String get mathematics => 'Mathematics'.tr();
  static String get physics => 'Physics'.tr();
  static String get chemistry => 'Chemistry'.tr();
  static String get biology => 'Biology'.tr();
  static String get biologicalScience => 'Biological Science'.tr();
  static String get science => 'Science'.tr();
  static String get philosophy => 'Philosophy'.tr();
  static String get history => 'History'.tr();
  static String get geography => 'Geography'.tr();
  static String get computerScience => 'Computer Science'.tr();
  static String get other => 'Other'.tr();
  static String get noTitle => 'no_title'.tr();
  static String get noSolution => 'no_solution'.tr();
  static String get notSolved => 'not_solved'.tr();
  static String get subjectGeneral => 'subject_general'.tr();
  static String get viewHeadline => 'view_headline'.tr();
  static String get viewSubHeadline => 'view_sub_headline'.tr();
  static String get questionsHeader => 'questions_header'.tr();
  static String get questionUnit => 'question_unit'.tr();
  static String get selectSubjectTitle => 'select_subject_title'.tr();
  static String get errorNoQuestions => 'error_no_questions'.tr();
  static String get generalExamTitle => 'general_exam_title'.tr();
  static String get subjectExamTitle => 'subject_exam_title'.tr();
  static String get createButton => 'create_button'.tr();
  static String get errorEmptyFields => 'error_empty_fields'.tr();
  static String get cannotSubscribeOwnCourseMessage =>
      'cannotSubscribeOwnCourseMessage'.tr();
  static String get courseNotPublishedMessage =>
      'courseNotPublishedMessage'.tr();
  static String get startLearningJourneyTitle =>
      'start_learning_journey_title'.tr();
  static String get description3 => 'description_3'.tr();
  static String get teacherToolsDescription => 'teacher_tools_description'.tr();
  static String get teacherFeaturesTitle => 'teacher_features_title'.tr();
  static String get teacherFeaturesDescription =>
      'teacher_features_description'.tr();
  static String get myPayments => 'MyPayments'.tr();
  static String get teacherStartTodayTitle => 'teacher_start_today_title'.tr();
  static String get teacherStartTodayDescription =>
      'teacher_start_today_description'.tr();
  static String get notAvailable => "notAvailable".tr();
  static String get transactionId => "transactionId".tr();
  static String get resetPassword => 'reset_password'.tr();
  static String get descriptionLabel => 'description_label'.tr();
  static String get chooseOption => 'choose_option'.tr();
  static String get support => 'support'.tr();
  static String get shared => 'shared'.tr();
  static String get darkMode => 'darkMode'.tr();
  static String get addTicket => 'addTicket'.tr();
  static String get ticketSentSuccess => 'ticketSentSuccess'.tr();
  static String get senderData => 'senderData'.tr();
  static String get fullName => 'fullName'.tr();
  static String get enterName => 'enterName'.tr();
  static String get problemDetails => 'problemDetails'.tr();
  static String get problemTitleHint => 'problemTitleHint'.tr();
  static String get problemTitleRequired => 'problemTitleRequired'.tr();
  static String get problemDescriptionHint => 'problemDescriptionHint'.tr();
  static String get problemDescriptionRequired =>
      'problemDescriptionRequired'.tr();
  static String get permissionError => 'permissionError'.tr();
  static String get selectTicketCategory => 'selectTicketCategory'.tr();
  static String get messageDeletedSuccess => 'messageDeletedSuccess'.tr();
  static String get noMessagesYet => 'noMessagesYet'.tr();
  static String get deleteMessage => 'deleteMessage'.tr();
  static String get updatedMessage => 'updatedMessage'.tr();
  static String get messageUpdatedSuccess => 'messageUpdatedSuccess'.tr();
  static String get videoLoadFailed => 'video_load_failed'.tr();
  static String get myCourses => 'my_courses'.tr();
  static String get totalPages => 'total_pages'.tr();
  static String get priceEgp => 'price_egp'.tr();
  static String get durationMinutes => 'duration_minutes'.tr();
  static String get questionsCount => 'questions_count'.tr();
  static String get minPrice => 'min_price'.tr();
  static String get maxPrice => 'max_price'.tr();
  static String get coupon => 'coupon'.tr();
  static String get performanceAnalysis => 'performance_analysis'.tr();
  static String get results => 'results'.tr();
  static String get studentSubscriptions => 'student_subscriptions'.tr();
  static String get wallet => 'wallet'.tr();
  static String get viewDetails => 'view_details'.tr();
  static String get resultAnalysis => 'result_analysis'.tr();
  static String get attendanceRate => 'attendance_rate'.tr();
  static String get videoNotes => 'video_notes'.tr();
  static String get snackSuccess => 'snack_success'.tr();
  static String get snackError => 'snack_error'.tr();
  static String get snackWarning => 'snack_warning'.tr();
  static String get aboutUsDescription => 'about_us_description'.tr();
  static String get aboutUsHighlightCourses =>
      'about_us_highlight_courses'.tr();
  static String get aboutUsHighlightExams => 'about_us_highlight_exams'.tr();
  static String get aboutUsHighlightProgress =>
      'about_us_highlight_progress'.tr();
  static String get aboutUsHighlightTeachers =>
      'about_us_highlight_teachers'.tr();

  static String get snackInfo => 'snack_info'.tr();
  static String get teacherSubjectTitle => 'teacher_subject_title'.tr();
  static String get imageNotFound => 'image_not_found'.tr();
  static String get somethingWrong => 'something_wrong'.tr();
  static String get videoNotFound => 'video_not_found'.tr();
  static String get fileNotFound => 'file_not_found'.tr();
  static String get couponAddError => 'coupon_add_error'.tr();
  static String get couponDeleteError => 'coupon_delete_error'.tr();
  static String get couponUpdateError => 'coupon_update_error'.tr();
  static String get dataNotFound => 'data_not_found'.tr();
  static String get fetchCouponsError => 'fetch_coupons_error'.tr();
  static String get couponNotFound => 'coupon_not_found'.tr();
  static String get unexpectedError => 'unexpected_error'.tr();
  static String get permissionDenied => 'permission_denied'.tr();
  static String get serverUnavailable => 'server_unavailable'.tr();
  static String get invalidArgument => 'invalid_argument'.tr();
  static String get deadlineExceeded => 'deadline_exceeded'.tr();
  static String get resourceExhausted => 'resource_exhausted'.tr();
  static String get weakPassword => 'weak_password'.tr();
  static String get emailInUse => 'email_in_use'.tr();
  static String get noInternet => 'no_internet'.tr();
  static String get operationNotAllowed => 'operation_not_allowed'.tr();
  static String get tooManyRequests => 'too_many_requests'.tr();
  static String get internalError => 'internal_error'.tr();
  static String get differentCredential => 'different_credential'.tr();
  static String get generalError => 'general_error'.tr();
  static String get popupBlocked => 'popup_blocked'.tr();
  static String get userDisabled => 'user_disabled'.tr();
  static String get imageLoadError => 'image_load_error'.tr();
  static String get emptyContent => 'empty_content'.tr();
  static String get agreeTerms => 'agree_terms'.tr();
  static String get errorOccurredMessage => 'error_occurred_message'.tr();
  static String get logoutConfirm => 'logout_confirm'.tr();
  static String get confirm => 'confirm'.tr();
  static String get cancel => 'cancel'.tr();
  static String get screenshotBlocked => 'screenshot_blocked'.tr();
  static String get recordingBlocked => 'recording_blocked'.tr();
  static String get favorites => 'favorites'.tr();
  static String get appBarRestorePassword => 'appBar_restore_password'.tr();
  static String get successEmailSent => 'success_email_sent'.tr();
  static String get sendLink => 'send_link'.tr();
  static String get resetPasswordDescription =>
      'reset_password_description'.tr();
  static String get loginQuestion => 'login_question'.tr();
  static String get contentCreator => 'content_creator'.tr();
  static String get successSubscribe => 'success_subscribe'.tr();
  static String get coursePriceLabel => 'course_price_label'.tr();
  static String get exploreContent => 'explore_content'.tr();
  static String get subscribeNow => 'subscribe_now'.tr();
  static String get enterCourse => 'enter_course'.tr();
  static String get welcomeBackHome => 'welcome_back_home'.tr();
  static String get latestCourses => 'latest_courses'.tr();
  static String get home => 'home'.tr();
  static String get search => 'search'.tr();
  static String get profile => 'profile'.tr();
  static String get contentLocked => 'content_locked'.tr();
  static String get writeMessageHint => 'write_message_hint'.tr();
  static String get emailHint => 'email_hint'.tr();
  static String get login => 'login'.tr();
  static String get firstName => 'first_name'.tr();
  static String get enterFirstName => 'enter_first_name'.tr();
  static String get lastName => 'last_name'.tr();
  static String get male => 'male'.tr();
  static String get female => 'female'.tr();
  static String get term1 => 'term_1'.tr();
  static String get term2 => 'term_2'.tr();
  static String get term3 => 'term_3'.tr();
  static String get term4 => 'term_4'.tr();
  static String get term5 => 'term_5'.tr();
  static String get term6 => 'term_6'.tr();
  static String get term7 => 'term_7'.tr();
  static String get studentTermsIntroTitle => 'student_terms_intro_title'.tr();
  static String get studentTermsIntroText => 'student_terms_intro_text'.tr();

  static String get studentTermsUsageTitle => 'student_terms_usage_title'.tr();
  static String get studentTermsUsageText => 'student_terms_usage_text'.tr();

  static String get studentTermsPaymentsTitle =>
      'student_terms_payments_title'.tr();
  static String get studentTermsPaymentsText =>
      'student_terms_payments_text'.tr();

  static String get studentTermsPrivacyTitle =>
      'student_terms_privacy_title'.tr();
  static String get studentTermsPrivacyText =>
      'student_terms_privacy_text'.tr();

  static String get studentTermsChangesTitle =>
      'student_terms_changes_title'.tr();
  static String get studentTermsChangesText =>
      'student_terms_changes_text'.tr();
  static String get signInGoogle => 'sign_in_google'.tr();
  static String get signInFacebook => 'sign_in_facebook'.tr();
  static String get orSeparator => 'or_separator'.tr();
  static String get enterLastName => 'enter_last_name'.tr();
  static String get experienceYears => 'experience_years'.tr();
  static String get enterExperienceYears => 'enter_experience_years'.tr();
  static String get subjectHint => 'subject_hint'.tr();
  static String get passwordHint => 'password_hint'.tr();
  static String get passwordRequired => 'password_required'.tr();
  static String get passwordMinLength => 'password_min_length'.tr();
  static String get emailRequired => 'email_required'.tr();
  static String get emailInvalid => 'email_invalid'.tr();
  static String get videoNotSupported => 'video_not_supported'.tr();
  static String get videoPlayFailed => 'video_play_failed'.tr();
  static String get videoError => 'video_error'.tr();
  static String get welcomeBack => 'welcome_back'.tr();
  static String get loginToContinue => 'login_to_continue'.tr();
  static String get addressHint => 'address_hint'.tr();
  static String get addressRequired => 'address_required'.tr();
  static String get phoneNumber => 'phone_number'.tr();
  // Education Levels
  static String get grade1Primary => 'grade_1_primary'.tr();
  static String get grade2Primary => 'grade_2_primary'.tr();
  static String get grade3Primary => 'grade_3_primary'.tr();
  static String get grade4Primary => 'grade_4_primary'.tr();
  static String get grade5Primary => 'grade_5_primary'.tr();
  static String get grade6Primary => 'grade_6_primary'.tr();
  static String get grade1Preparatory => 'grade_1_preparatory'.tr();
  static String get grade2Preparatory => 'grade_2_preparatory'.tr();
  static String get grade3Preparatory => 'grade_3_preparatory'.tr();
  static String get grade1Secondary => 'grade_1_secondary'.tr();
  static String get grade2Secondary => 'grade_2_secondary'.tr();
  static String get grade3Secondary => 'grade_3_secondary'.tr();

  // Subjects
  static String get subjectArabic => 'subject_arabic'.tr();
  static String get subjectEnglish => 'subject_english'.tr();
  static String get subjectFrench => 'subject_french'.tr();
  static String get subjectItalian => 'subject_italian'.tr();
  static String get subjectSpanish => 'subject_spanish'.tr();
  static String get subjectMathematics => 'subject_mathematics'.tr();
  static String get subjectPhysics => 'subject_physics'.tr();
  static String get subjectChemistry => 'subject_chemistry'.tr();
  static String get subjectBiology => 'subject_biology'.tr();
  static String get subjectBiologicalScience =>
      'subject_biological_science'.tr();
  static String get subjectScience => 'subject_science'.tr();
  static String get subjectPhilosophy => 'subject_philosophy'.tr();
  static String get subjectHistory => 'subject_history'.tr();
  static String get subjectGeography => 'subject_geography'.tr();
  static String get subjectComputerScience => 'subject_computer_science'.tr();
  static String get subjectOther => 'subject_other'.tr();
  static String get phoneRequired => 'phone_required'.tr();
  static String get phoneInvalid => 'phone_invalid'.tr();
  static String get createAccount => 'create_account'.tr();
  static String get mustChooseSubject => 'must_choose_subject'.tr();
  static String get mustAcceptTerms => 'must_accept_terms'.tr();
  static String get studentRole => 'student_role'.tr();
  static String get teacherRole => 'teacher_role'.tr();
  static String get completeProfileTitle => 'complete_profile_title'.tr();
  static String get completeProfileSubtitle => 'complete_profile_subtitle'.tr();
  static String get completeProfilePhoneHint =>
      'complete_profile_phone_hint'.tr();
  static String get completeProfileEducationLevel =>
      'complete_profile_education_level'.tr();
  static String get completeProfileEducationLevelHint =>
      'complete_profile_education_level_hint'.tr();
  static String get genderMale => 'gender_male'.tr();
  static String get genderFemale => 'gender_female'.tr();
  static String get chooseRoleStudent => 'choose_role_student'.tr();
  static String get chooseRoleTeacher => 'choose_role_teacher'.tr();
  static String get startAsButton => 'start_as_button'.tr();
  static String get teacherDetails => 'teacher_details'.tr();
  static String get noCourses => 'no_courses'.tr();
  static String get coursecodeexists => 'course_code_exists'.tr();

  static String get coursesLabel => 'courses_label'.tr();
  static String get studentsLabel => 'students_label'.tr();
  static String get reportInappropriate => 'report_inappropriate'.tr();
  static String get reportInappropriateDescription =>
      'report_inappropriate_description'.tr();
  static String get reportWrongInfo => 'report_wrong_info'.tr();
  static String get reportWrongInfoDescription =>
      'report_wrong_info_description'.tr();
  static String get reportMisleading => 'report_misleading'.tr();
  static String get reportMisleadingDescription =>
      'report_misleading_description'.tr();
  static String get reportTechnicalIssue => 'report_technical_issue'.tr();
  static String get reportCopyright => 'report_copyright'.tr();
  static String get reportUnfit => 'report_unfit'.tr();
  static String get reportLowQuality => 'report_low_quality'.tr();
  static String get reportPriceIssue => 'report_price_issue'.tr();
  static String get reportUnprofessional => 'report_unprofessional'.tr();
  static String get reportOther => 'report_other'.tr();
  static String get reportOtherDescription => 'report_other_description'.tr();
  static String get reportResolved => 'report_resolved'.tr();
  static String get reportDismissed => 'report_dismissed'.tr();
  static String get reportOpen => 'report_open'.tr();
  static String get reportMarkResolved => 'report_mark_resolved'.tr();
  static String get reportDismissAction => 'report_dismiss_action'.tr();
  static String get reportDescriptionTooShort =>
      'report_description_too_short'.tr();
  static String get reportDescriptionTooLong =>
      'report_description_too_long'.tr();
  static String get reportStudent => 'report_student'.tr();
  static String get reportTotal => 'report_total'.tr();
  static String get reportShowLess => 'report_show_less'.tr();
  static String reportResolvedOnFor(String date) =>
      'report_resolved_on'.tr(args: {'date': date});
  static String reportDismissedOnFor(String date) =>
      'report_dismissed_on'.tr(args: {'date': date});

  static String get courseReportsTitle => 'course_reports_title'.tr();
  static String get reportSearchHint => 'report_search_hint'.tr();
  static String get reportFilterAll => 'report_filter_all'.tr();
  static String get reportSummaryTotalCaption =>
      'report_summary_total_caption'.tr();
  static String get reportSummaryOpenCaption =>
      'report_summary_open_caption'.tr();
  static String get reportSummaryResolvedCaption =>
      'report_summary_resolved_caption'.tr();
  static String get reportSummaryDismissedCaption =>
      'report_summary_dismissed_caption'.tr();
  static String get reportSortNewest => 'report_sort_newest'.tr();
  static String get reportSortOldest => 'report_sort_oldest'.tr();
  static String get reportTypeFilterLabel => 'report_type_filter_label'.tr();
  static String get reportShowMore => 'report_show_more'.tr();
  static String get reportResolvedOn => 'report_resolved_on'.tr();
  static String get reportDismissedOn => 'report_dismissed_on'.tr();
  static String get reportDetailsTitle => 'report_details_title'.tr();
  static String get reportFullText => 'report_full_text'.tr();
  static String get reportSubmittedBy => 'report_submitted_by'.tr();
  static String get reportReporterHidden => 'report_reporter_hidden'.tr();
  static String get reportSubmittedAt => 'report_submitted_at'.tr();
  static String get reportStatusChangeHint => 'report_status_change_hint'.tr();
  static String get reportSelectPrompt => 'report_select_prompt'.tr();
  static String get reportActionReopen => 'report_action_reopen'.tr();
  static String get reportDismissConfirmTitle =>
      'report_dismiss_confirm_title'.tr();
  static String get reportDismissConfirmBody =>
      'report_dismiss_confirm_body'.tr();
  static String get reportStatusUpdated => 'report_status_updated'.tr();
  static String get reportStatusUpdateFailed =>
      'report_status_update_failed'.tr();
  static String get reportClearFilters => 'report_clear_filters'.tr();
  static String get reportNoResults => 'report_no_results'.tr();
  static String get reportEmptyTitle => 'report_empty_title'.tr();
  static String get reportEmptySubtitle => 'report_empty_subtitle'.tr();
  static String get reportRetry => 'report_retry'.tr();
  static String get reportTimeJustNow => 'report_time_just_now'.tr();
  static String get reportTimeMinuteOne => 'report_time_minute_one'.tr();
  static String get reportTimeMinuteTwo => 'report_time_minute_two'.tr();
  static String get reportTimeMinuteFew => 'report_time_minute_few'.tr();
  static String get reportTimeMinuteMany => 'report_time_minute_many'.tr();
  static String get reportTimeHourOne => 'report_time_hour_one'.tr();
  static String get reportTimeHourTwo => 'report_time_hour_two'.tr();
  static String get reportTimeHourFew => 'report_time_hour_few'.tr();
  static String get reportTimeHourMany => 'report_time_hour_many'.tr();
  static String get reportTimeDayOne => 'report_time_day_one'.tr();
  static String get reportTimeDayTwo => 'report_time_day_two'.tr();
  static String get reportTimeDayFew => 'report_time_day_few'.tr();
  static String get reportTimeDayMany => 'report_time_day_many'.tr();

  static String get studentsReviews => 'students_reviews'.tr();
  static String get examResults => 'exam_results'.tr();
  static String get reportPage => 'report_page'.tr();
  static String get loggingIn => 'logging_in'.tr();
  static String get minutesSuffix => 'minutes_suffix'.tr();
  static String get questionsSuffix => 'questions_suffix'.tr();
  static String get commentAdded => 'comment_added'.tr();
  static String get mostViewed => 'most_viewed'.tr();
  static String get seeMore => 'see_more'.tr();
  static String get noPopularCourses => 'no_popular_courses'.tr();
  static String get recommended => 'recommended'.tr();
  static String get noRecommendedCourses => 'no_recommended_courses'.tr();
  static String get myCoursesAppbar => 'my_courses_appbar'.tr();
  static String get noMyCourses => 'no_my_courses'.tr();
  static String get myMistakesAppbar => 'my_mistakes_appbar'.tr();
  static String get noMistakes => 'no_mistakes'.tr();
  static String get myResultsAppbar => 'my_results_appbar'.tr();
  static String get noResults => 'no_results'.tr();
  static String get noImageSelected => 'no_image_selected'.tr();
  static String get noImageFound => 'no_image_found'.tr();
  static String get uploadImageFailed => 'upload_image_failed'.tr();
  static String get profilePersonalData => 'profile_personal_data'.tr();
  static String get profileMyCourses => 'profile_my_courses'.tr();
  static String get profileFavorites => 'profile_favorites'.tr();
  static String get profileResults => 'profile_results'.tr();
  static String get profileMistakes => 'profile_mistakes'.tr();
  static String get addExamDetailsTitle => 'AddExamDetailsTitle'.tr();
  static String get examQuestionsTitle => 'ExamQuestionsTitle'.tr();
  static String get yes => 'Yes'.tr();
  static String get no => 'No'.tr();
  static String get maxAttemptsReached => 'MaxAttemptsReached'.tr();
  static String get secureEncryptedProtected => 'SecureEncryptedProtected'.tr();
  static String get resultHiddenByTeacher => 'ResultHiddenByTeacher'.tr();
  static String get resultWillBeShown => 'ResultWillBeShown'.tr();
  static String get unlimited => 'Unlimited'.tr();
  static String get examAttemptsCount => 'ExamAttemptsCount'.tr();
  static String get hideResultAfterSubmit => 'HideResultAfterSubmit'.tr();
  static String get examReviewTitle => 'ExamReviewTitle'.tr();
  static String get profileSettings => 'profile_settings'.tr();
  static String get profileAbout => 'profile_about'.tr();
  static String get lowestToHighest => 'lowest_to_highest'.tr();
  static String get highestToLowest => 'highest_to_lowest'.tr();
  static String get addCoursesToFavorites => 'add_courses_to_favorites'.tr();
  static String get workEnvironment => 'work_environment'.tr();
  static String get accountAndActivity => 'account_and_activity'.tr();
  static String get settingsAndSupport => 'settings_and_support'.tr();
  static String get workEnvironmentSubtitle => 'work_environment_subtitle'.tr();
  static String get profileSupport => 'profile_support'.tr();
  static String get profileEmail => 'profile_email'.tr();
  static String get profileGender => 'profile_gender'.tr();
  static String get profileRole => 'profile_role'.tr();
  static String get courseRequestSentSuccess =>
      'course_request_sent_success'.tr();

  static String get enterCourseName => 'enter_course_name'.tr();
  static String get courseName => 'course_name'.tr();

  static String get courseCode => 'course_code'.tr();
  static String get enterCourseCode => 'enter_course_code'.tr();

  static String get courseDescription => 'course_description'.tr();
  static String get enterCourseDescription => 'enter_course_description'.tr();

  static String get price => 'price'.tr();
  static String get enterPrice => 'enter_price'.tr();

  static String get language => 'language'.tr();
  static String get courseThumbnail => 'course_thumbnail'.tr();
  static String get profileJoinedDate => 'profile_joined_date'.tr();
  static String get profileContact => 'profile_contact'.tr();
  static String get profilePhone => 'profile_phone'.tr();
  static String get profileAddress => 'profile_address'.tr();
  static String get studentData => 'student_data'.tr();
  static String get studentEducationLevel => 'student_education_level'.tr();
  static String get studentBirthDate => 'student_birth_date'.tr();
  static String get teacherData => 'teacher_data'.tr();
  static String get teacherSubject => 'teacher_subject'.tr();
  static String get teacherExperience => 'teacher_experience'.tr();
  static String get unknownError => 'unknown_error'.tr();
  static String get noTeachers => 'no_teachers'.tr();
  static String get ourCourses => 'our_courses'.tr();
  static String get ourTeachers => 'our_teachers'.tr();
  static String get filter => 'filter'.tr();
  static String get restoreDefaultFilters => 'restore_default_filters'.tr();
  static String get filterCourses => 'filter_courses'.tr();
  static String get subscription => 'subscription'.tr();
  static String get sortByPrice => 'sort_by_price'.tr();
  static String get missingFields => 'missing_fields'.tr();
  static String get missingImage => 'missing_image'.tr();
  static String get createdby => 'created_by'.tr();
  static String get submitReport => 'submit_report'.tr();
  static String get otherStudentsReviews => 'other_students_reviews'.tr();
  static String get invalidPrice => 'invalid_price'.tr();
  static String get priceWarning => 'price_warning'.tr();
  static String get moreFilters => 'more_filters'.tr();
  static String get lowestPrice => 'lowest_price'.tr();
  static String get highestPrice => 'highest_price'.tr();
  static String get showMore => 'show_more'.tr();
  static String get showLess => 'show_less'.tr();
  static String get paid => 'paid'.tr();
  static String get courseContent => 'course_content'.tr();
  static String get contentComingSoon => 'content_coming_soon'.tr();
  static String get reportReasons => 'report_reasons'.tr();
  static String get reportDescription => 'report_description'.tr();
  static String get sendCourseReportTitle => 'send_course_report_title'.tr();
  static String get sendCourseReportPrivacyNotice =>
      'send_course_report_privacy_notice'.tr();
  static String get reportSentSuccessfully => 'report_sent_successfully'.tr();
  static String get report => 'report'.tr();
  static String get mustSubscribeToReport => 'must_subscribe_to_report'.tr();
  static String get commentPostedSuccessfully =>
      'comment_posted_successfully'.tr();
  static String get mustSubscribeToComment => 'must_subscribe_to_comment'.tr();
  static String get fieldCannotBeEmpty => 'field_cannot_be_empty'.tr();
  static String get free => 'free'.tr();
  static String get registrationSuccess => 'registration_success'.tr();
  static String get examCompletedSuccess => 'exam_completed_success'.tr();
  static String get submitExam => 'submit_exam'.tr();
  static String get invalidCoupon => 'invalid_coupon'.tr();
  static String get courseDetails => 'course_details'.tr();
  static String get discountedPrice => 'discounted_price'.tr();
  static String get originalPrice => 'original_price'.tr();
  static String get couponDiscount => 'coupon_discount'.tr();
  static String get applyingCoupon => 'applying_coupon'.tr();
  static String get couponApplied => 'coupon_applied'.tr();
  static String get examName => 'exam_name'.tr();
  static String get enterExamName => 'enter_exam_name'.tr();
  static String get examDuration => 'exam_duration'.tr();
  static String get enterDuration => 'enter_duration'.tr();
  static String get examDetails => 'exam_details'.tr();
  static String get examQuestions => 'exam_questions'.tr();
  static String get questionNumber => 'question_number'.tr();
  static String get of => 'of'.tr();
  static String get enterQuestionHere => 'enter_question_here'.tr();
  static String get enterQuestion => 'enter_question'.tr();
  static String get answer => 'answer'.tr();
  static String get enterAnswer => 'enter_answer'.tr();
  static String get addAnswer => 'add_answer'.tr();
  static String get addQuestion => 'add_question'.tr();
  static String get save => 'save'.tr();
  static String get questionImage => 'question_image'.tr();
  static String get answerImage => 'answer_image'.tr();
  static String get discount => 'discount'.tr();
  static String get wrongAnswer => 'wrong_answer'.tr();
  static String get questionNotFound => 'question_not_found'.tr();
  static String get hideSolution => 'hide_solution'.tr();
  static String get showSolution => 'show_solution'.tr();
  static String get totalQuestions => 'total_questions'.tr();
  static String get questionsSolved => 'questions_solved'.tr();
  static String get correctQuestions => 'correct_questions'.tr();
  static String get wrongQuestions => 'wrong_questions'.tr();
  static String get answeredQuestions => 'answered_questions'.tr();
  static String get unansweredQuestions => 'unanswered_questions'.tr();
  static String get startTest => 'start_test'.tr();
  static String get previousResults => 'previous_results'.tr();
  static String get subscribed => 'subscribed'.tr();
  static String get unsubscribed => 'unsubscribed'.tr();
  static String get facedSomeIssues => 'faced_some_issues'.tr();
  static String get sendNote => 'send_note'.tr();
  static String get send => 'send'.tr();
  static String get noteAddedSuccessfully => 'note_added_successfully'.tr();
  static String get noNewCourses => 'no_new_courses'.tr();
  static String get hintWriteMessage => 'hint_write_message'.tr();
  static String get hintEmail => 'hint_email'.tr();
  static String get hintPassword => 'hint_password'.tr();
  static String get errorEmptyPassword => 'error_empty_password'.tr();
  static String get errorShortPassword => 'error_short_password'.tr();
  static String get errorEmptyEmail => 'error_empty_email'.tr();
  static String get errorInvalidEmail => 'error_invalid_email'.tr();
  static String get videoUnsupported => 'video_unsupported'.tr();
  static String get videoFailed => 'video_failed'.tr();
  static String get videoCannotPlay => 'video_cannot_play'.tr();
  static String get successImageChanged => 'success_image_changed'.tr();
  static String get logout => 'logout'.tr();
  static String get postedMonth => 'posted_month'.tr();
  static String get postedDay => 'posted_day'.tr();
  static String get postedHour => 'posted_hour'.tr();
  static String get postedMinute => 'posted_minute'.tr();
  static String get studentsAttended => 'students_attended'.tr();
  static String get studentsAbsent => 'students_absent'.tr();
  static String get noNotes => 'no_notes'.tr();
  static String get studentsPassed => 'students_passed'.tr();
  static String get studentsFailed => 'students_failed'.tr();
  static String get testResults => 'test_results'.tr();
  static String get evaluationRate => 'evaluation_rate'.tr();
  static String get studentScore => 'student_score'.tr();
  static String get viewResult => 'view_result'.tr();
  static String get studentNumber => 'student_number'.tr();
  static String get joinedDate => 'joined_date'.tr();
  static String get lowestScore => 'lowest_score'.tr();
  static String get highestScore => 'highest_score'.tr();
  static String get resultsAnalysis => 'results_analysis'.tr();
  static String get averageResults => 'average_results'.tr();
  static String get walletDetailsTitle => 'wallet_details_title'.tr();
  static String get withdrawBalance => 'withdraw_balance'.tr();
  static String get walletStatus => 'wallet_status'.tr();
  static String get totalBalance => 'total_balance'.tr();
  static String get walletBalance => 'wallet_balance'.tr();
  static String get pendingBalance => 'pending_balance'.tr();
  static String get active => 'active'.tr();
  static String get closed => 'closed'.tr();
  static String get pending => 'pending'.tr();
  static String get addNewCourse => 'add_new_course'.tr();
  static String get termsConditions => 'terms_conditions'.tr();
  static String get walletNumberHint => 'wallet_number_hint'.tr();
  static String get enterWalletNumber => 'enter_wallet_number'.tr();
  static String get enterValidWalletNumber => 'enter_valid_wallet_number'.tr();
  static String get amountHint => 'amount_hint'.tr();
  static String get enterAmount => 'enter_amount'.tr();
  static String get sendMoney => 'send_money'.tr();
  static String get invalidAmount => 'invalid_amount'.tr();
  static String get walletNotActive => 'wallet_not_active'.tr();
  static String get insufficientBalance => 'insufficient_balance'.tr();
  static String get walletNumberMismatch => 'wallet_number_mismatch'.tr();
  static String get statusActive => 'status_active'.tr();
  static String get statusClosed => 'status_closed'.tr();
  static String get statusPending => 'status_pending'.tr();
  static String get createdDate => 'created_date'.tr();
  static String get updatedDate => 'updated_date'.tr();
  static String get currentBalance => 'current_balance'.tr();
  static String get totalEarned => 'total_earned'.tr();
  static String get pendingBalanceLabel => 'pending_balance_label'.tr();
  static String get currency => 'currency'.tr();
  static String get lectureTitle => 'lecture_title'.tr();
  static String get addFile => 'add_file'.tr();
  static String get fileAddedSuccessfully => 'file_added_successfully'.tr();
  static String get fileSelectionError => 'file_selection_error'.tr();
  static String get sectionAddedSuccessfully =>
      'section_added_successfully'.tr();
  static String get enterFileNameHere => 'enter_file_name_here'.tr();
  static String get enterFileName => 'enter_file_name'.tr();
  static String get enterFileDescriptionHere =>
      'enter_file_description_here'.tr();
  static String get addVideo => 'add_video'.tr();
  static String get addLecture => 'add_lecture'.tr();
  static String get content => 'content'.tr();
  static String get enterLectureNameHere => 'enter_lecture_name_here'.tr();
  static String get enterLectureName => 'enter_lecture_name'.tr();
  static String get enterLectureDescriptionHere =>
      'enter_lecture_description_here'.tr();
  static String get operationSuccessful => 'operation_successful'.tr();
  static String get contentDescription => 'content_description'.tr();
  static String get students => 'students'.tr();
  static String get studentsDescription => 'students_description'.tr();
  static String get studentsReviewsDescription =>
      'students_reviews_description'.tr();
  static String get addCoupon => 'add_coupon'.tr();
  static String get couponAddedSuccessfully => 'coupon_added_successfully'.tr();
  static String get enterCouponCodeHere => 'enter_coupon_code_here'.tr();
  static String get enterCouponCode => 'enter_coupon_code'.tr();
  static String get enterCouponDiscountHere =>
      'enter_coupon_discount_here'.tr();
  static String get areYouSureDeleteSection =>
      'are_you_sure_delete_section'.tr();
  static String get accountCreatedSuccessfully =>
      'account_created_successfully'.tr();
  static String get connectionTimeout => 'connection_timeout'.tr();
  static String get sendTimeout => 'send_timeout'.tr();
  static String get receiveTimeout => 'receive_timeout'.tr();
  static String get badCertificate => 'bad_certificate'.tr();
  static String get requestCancelled => 'request_cancelled'.tr();
  static String get badRequest => 'bad_request'.tr();
  static String get unauthorized => 'unauthorized'.tr();
  static String get forbidden => 'forbidden'.tr();
  static String get notFound => 'not_found'.tr();
  static String get searchplaceholder => 'search_placeholder'.tr();
  static String get unprocessableEntity => 'unprocessable_entity'.tr();
  static String get internalServerError => 'internal_server_error'.tr();
  static String get serviceUnavailable => 'service_unavailable'.tr();
  static String get unknownStatusCode => 'unknown_status_code'.tr();
  static String get serverConnectionError => 'server_connection_error'.tr();
  static String get deviceNotFound => 'device_not_found'.tr();
  static String get courseDeleteNotice => 'course_delete_notice'.tr();
  static String get deviceMismatch => 'device_mismatch'.tr();
  static String get teacherRequestReview => 'teacher_request_review'.tr();
  static String get favoriteLimitError => 'favorite_limit_error'.tr();
  static String get attempt => 'attempt'.tr();
  static String get verificationSent => 'verification_sent'.tr();
  static String get errorStoringUser => 'error_storing_user'.tr();
  static String get userNotFound => 'user_not_found'.tr();
  static String get userBlocked => 'user_blocked'.tr();
  static String get userPending => 'user_pending'.tr();
  static String get userRejected => 'user_rejected'.tr();
  static String get userInactive => 'user_inactive'.tr();
  static String get verificationNotSent => 'verification_not_sent'.tr();
  static String get userNotExist => 'user_not_exist'.tr();
  static String get wrongPassword => 'wrong_password'.tr();
  static String get videoReports => 'video_reports'.tr();
  static String get testReports => 'test_reports'.tr();
  static String get noSubscribersInCourse => 'no_subscribers_in_course'.tr();
  static String get subscribersCount => 'subscribers_count'.tr();
  static String get person => 'person'.tr();
  static String get enterCouponDiscount => 'enter_coupon_discount'.tr();
  static String get expirationDate => 'expiration_date'.tr();
  static String get enterCouponsCountHere => 'enter_coupons_count_here'.tr();
  static String get enterCouponsCount => 'enter_coupons_count'.tr();
  static String get add => 'add'.tr();
  static String get coupons => 'coupons'.tr();
  static String get expiresIn => 'expires_in'.tr();

  static String get codeUsed => 'code_used'.tr();
  static String get codeDisabled => 'code_disabled'.tr();
  static String get couponsDescription => 'coupons_description'.tr();
  static String get reports => 'reports'.tr();
  static String get reportsDescription => 'reports_description'.tr();
  static String get hideCourseWarning => 'hide_course_warning'.tr();
  static String get restore => 'restore'.tr();
  static String get delete => 'delete'.tr();
  static String get enterLectureDescription => 'enter_lecture_description'.tr();
  static String get video => 'video'.tr();
  static String get exam => 'exam'.tr();
  static String get file => 'file'.tr();
  static String get videoAddedSuccessfully => 'video_added_successfully'.tr();
  static String get videoUploadError => 'video_upload_error'.tr();
  static String get enterVideoNameHere => 'enter_video_name_here'.tr();
  static String get enterVideoName => 'enter_video_name'.tr();
  static String get selectVideo => 'select_video'.tr();
  static String get addVideoButton => 'add_video_button'.tr();
  static String get enterFileDescription => 'enter_file_description'.tr();
  static String get addFileButton => 'add_file_button'.tr();
  static String get selectFile => 'select_file'.tr();
  static String get lectureDescription => 'lecture_description'.tr();
  static String get examReview => 'exam_review'.tr();
  static String get numberOfQuestions => 'number_of_questions'.tr();
  static String get addExam => 'add_exam'.tr();
  static String get payoutIntroTitle => 'payout_intro_title'.tr();
  static String get payoutIntroBody => 'payout_intro_body'.tr();
  static String get payoutMethodTitle => 'payout_method_title'.tr();
  static String get payoutMethodBody => 'payout_method_body'.tr();
  static String get payoutEligibilityTitle => 'payout_eligibility_title'.tr();
  static String get payoutEligibilityBody => 'payout_eligibility_body'.tr();
  static String get payoutMinimumTitle => 'payout_minimum_title'.tr();
  static String get payoutMinimumBody => 'payout_minimum_body'.tr();
  static String get payoutProcessingTitle => 'payout_processing_title'.tr();
  static String get payoutProcessingBody => 'payout_processing_body'.tr();
  static String get payoutFeesTitle => 'payout_fees_title'.tr();
  static String get payoutFeesBody => 'payout_fees_body'.tr();
  static String get payoutUpdateInfoTitle => 'payout_update_info_title'.tr();
  static String get payoutUpdateInfoBody => 'payout_update_info_body'.tr();
  static String get payoutRefundsTitle => 'payout_refunds_title'.tr();
  static String get payoutRefundsBody => 'payout_refunds_body'.tr();
  static String get payoutFraudTitle => 'payout_fraud_title'.tr();
  static String get payoutFraudBody => 'payout_fraud_body'.tr();
  static String get payoutSupportTitle => 'payout_support_title'.tr();
  static String get payoutSupportBody => 'payout_support_body'.tr();
  static String get payoutAcceptanceTitle => 'payout_acceptance_title'.tr();
  static String get payoutAcceptanceBody => 'payout_acceptance_body'.tr();
  static String get withdrawFromWalletLabel =>
      'withdraw_from_wallet_label'.tr();
  static String get transactionDetailsTitle => 'transaction_details_title'.tr();
  static String get paymentMethodLabel => 'payment_method_label'.tr();
  static String get phoneNumberLabel => 'phone_number_label'.tr();
  static String get entityLabel => 'entity_label'.tr();
  static String get copyTransactionIdTooltip =>
      'copy_transaction_id_tooltip'.tr();
  static String get transactionStatusUpdatedSuccess =>
      'transaction_status_updated_success'.tr();
  static String get reconcileMissingIdError =>
      'reconcile_missing_id_error'.tr();
  static String get walletIdLabel => 'wallet_id_label'.tr();
  static String get walletCurrencyLabel => 'wallet_currency_label'.tr();
  static String get walletStatusLabel => 'wallet_status_label'.tr();
  static String get walletCreatedAtLabel => 'wallet_created_at_label'.tr();
  static String get walletUpdatedAtLabel => 'wallet_updated_at_label'.tr();
  static String get lastTransactionIdLabel => 'last_transaction_id_label'.tr();
  static String get currencyUsd => 'currency_usd'.tr();
  static String get currencyEur => 'currency_eur'.tr();
  static String get currencyEgpSymbol => 'currency_egp_symbol'.tr();

  static String reconcileStatusCheckFailed(String message) =>
      'reconcile_status_check_failed'.tr(args: {'message': message});

  static String reconcileDbUpdateFailed({
    required String message,
    required String status,
    required String description,
  }) => 'reconcile_db_update_failed'.tr(
    args: {'message': message, 'status': status, 'description': description},
  );

  static String reconcileTransactionFailedMessage(String reason) =>
      'reconcile_transaction_failed_message'.tr(args: {'reason': reason});

  // Wallet body / errors
  static String get walletNotFoundError => 'wallet_not_found_error'.tr();
  static String get walletDocumentEmptyError =>
      'wallet_document_empty_error'.tr();
  static String get walletRetry => 'wallet_retry'.tr();
  static String get walletStaleNotice => 'wallet_stale_notice'.tr();
  static String get walletStatusInactive => 'wallet_status_inactive'.tr();
  static String get walletStatusSuspended => 'wallet_status_suspended'.tr();
  static String get walletWithdrawUnavailableTitle =>
      'wallet_withdraw_unavailable_title'.tr();
  static String get walletWithdrawUnavailableMessage =>
      'wallet_withdraw_unavailable_message'.tr();
  static String get walletWithdrawUnavailableBack =>
      'wallet_withdraw_unavailable_back'.tr();

  // Transactions header
  static String get recentTransactionsTitle => 'recent_transactions_title'.tr();

  // Wallet card
  static String get academicWalletTitle => 'academic_wallet_title'.tr();
  static String get walletSubtitle => 'wallet_subtitle'.tr();
  static String get noWalletDataAvailable => 'no_wallet_data_available'.tr();
  static String get availableBalanceLabel => 'available_balance_label'.tr();

  // Profit settlement note
  static String get profitSettlementNoteTitle =>
      'profit_settlement_note_title'.tr();
  static String get profitSettlementNoteDescription =>
      'profit_settlement_note_description'.tr();

  // Wallet details expandable
  static String get walletDetailsHeaderTitle =>
      'wallet_details_header_title'.tr();

  // Earnings summary
  static String get totalEarningsLabel => 'total_earnings_label'.tr();
  static String get pendingWithdrawalLabel => 'pending_withdrawal_label'.tr();
  static String get availableForWithdrawalLabel =>
      'available_for_withdrawal_label'.tr();
  static String get earningsSummaryTitle => 'earnings_summary_title'.tr();
  static String get earningsSummaryUpdateNote =>
      'earnings_summary_update_note'.tr();
  static String get transactionIdCopiedTooltip =>
      'transaction_id_copied_tooltip'.tr();
  static String get transactionDateLabel => 'transaction_date_label'.tr();
  static String get reconciliationStatusRowLabel =>
      'reconciliation_status_row_label'.tr();
  static String get reconciliationStatusDone =>
      'reconciliation_status_done'.tr();
  static String get reconciliationStatusPending =>
      'reconciliation_status_pending'.tr();
  static String get transactionIdLabel => 'transaction_id_label'.tr();
  static String get closeButtonLabel => 'close_button_label'.tr();
  static String get withdrawalRequestTitle => 'withdrawal_request_title'.tr();
  static String get transactionStatusCompleted =>
      'transaction_status_completed'.tr();
  static String get transactionStatusPending =>
      'transaction_status_pending'.tr();
  static String get transactionStatusRejected =>
      'transaction_status_rejected'.tr();
  static String get issuerOrangeCash => 'issuer_orange_cash'.tr();
  static String get issuerVodafoneCash => 'issuer_vodafone_cash'.tr();
  static String get issuerEtisalatCash => 'issuer_etisalat_cash'.tr();
  static String get issuerWePay => 'issuer_we_pay'.tr();
  static String get issuerUnknown => 'issuer_unknown'.tr();
  static String get currencyEGP => 'currency_egp'.tr();
  static String get withdrawalAmount => 'withdrawal_amount'.tr();
  static String get withdrawalAllBalance => 'withdrawal_all_balance'.tr();
  static String get withdrawalMinimum => 'withdrawal_minimum'.tr();
  static String get withdrawalValidAmount => 'withdrawal_valid_amount'.tr();
  static String get withdrawalReceivingMethod =>
      'withdrawal_receiving_method'.tr();
  static String get withdrawalDirectTransfer =>
      'withdrawal_direct_transfer'.tr();
  static String get withdrawalInstant => 'withdrawal_instant'.tr();
  static String get withdrawalRecipientNumber =>
      'withdrawal_recipient_number'.tr();
  static String get withdrawalAccountMatch => 'withdrawal_account_match'.tr();
  static String get withdrawalSummary => 'withdrawal_summary'.tr();
  static String get withdrawalRequested => 'withdrawal_requested'.tr();
  static String get withdrawalFees => 'withdrawal_fees'.tr();
  static String get withdrawalFree => 'withdrawal_free'.tr();
  static String get withdrawalNet => 'withdrawal_net'.tr();
  static String get withdrawalConfirm => 'withdrawal_confirm'.tr();
  static String get withdrawalSubmitted => 'withdrawal_submitted'.tr();
  static String get withdrawalBalanceUpdated =>
      'withdrawal_balance_updated'.tr();
  static String get withdrawalReadyForDeposit =>
      'withdrawal_ready_for_deposit'.tr();
  static String get withdrawalSecureBalance => 'withdrawal_secure_balance'.tr();
  static String get withdrawalInvalidRecipientNumber =>
      'withdrawal_invalid_recipient_number'.tr();
  static String get courseManagement => 'course_management'.tr();
  static String get courseManagementCount => 'course_management_count'.tr();
  static String get courseInstructor => 'course_instructor'.tr();
  static String get editCourse => 'edit_course'.tr();
  static String get archiveCourse => 'archive_course'.tr();
  static String get restoreCourse => 'restore_course'.tr();
  static String get courseStatePublished => 'course_state_published'.tr();
  static String get courseStatePending => 'course_state_pending'.tr();
  static String get courseStateArchived => 'course_state_archived'.tr();
  static String get archiveConfirmationTitle =>
      'archive_confirmation_title'.tr();
  static String get archiveConfirmationMessage =>
      'archive_confirmation_message'.tr();
  static String get confirmArchive => 'confirm_archive'.tr();
  static String get videoPickerTitle => 'video_picker_title'.tr();
  static String videoConstraints(String size) =>
      'video_constraints_label'.tr(args: {'size': '\u2068$size\u2069'});
  static String videoFileTooLarge(String size) =>
      'video_file_too_large'.tr(args: {'size': '\u2068$size\u2069'});
  static String get videoUnsupportedFileType =>
      'video_file_type_unsupported'.tr();
  static String get videoPickerSubtitle => 'video_picker_subtitle'.tr();
  static String get browseVideoFiles => 'browse_video_files'.tr();
  static String get videoReadyToUpload => 'video_ready_to_upload'.tr();
  static String get changeVideo => 'change_video'.tr();
  static String get removeSelectedVideo => 'remove_selected_video'.tr();
  static String get videoUploadProgress => 'video_upload_progress'.tr();
  static String get videoUploadingTitle => 'video_uploading_title'.tr();
  static String videoUploadBytes(String uploaded, String size) =>
      'video_upload_bytes'.tr(args: {'uploaded': uploaded, 'size': size});
  static String videoEta(int seconds) =>
      'video_eta'.tr(args: {'seconds': '$seconds'});
  static String get calculatingEta => 'calculating_eta'.tr();
  static String get cancelUpload => 'cancel_upload'.tr();
  static String get videoTitleLabel => 'video_title_label'.tr();
  static String get videoTitleHint => 'video_title_hint'.tr();
  static String get videoTitleHelper => 'video_title_helper'.tr();
  static String get videoTitleRequired => 'video_title_required'.tr();
  static String get allowVideoComments => 'allow_video_comments'.tr();
  static String get allowVideoCommentsDescription =>
      'allow_video_comments_description'.tr();
  static String get videoStandardsTitle => 'video_standards_title'.tr();
  static String get videoStandardsBody => 'video_standards_body'.tr();
  static String get uploadAndSaveVideo => 'upload_and_save_video'.tr();
  static String uploadingVideoButton(int percent) =>
      'uploading_video_button'.tr(args: {'percent': '$percent'});
  static String get savingVideo => 'saving_video'.tr();
  static String get retryUpload => 'retry_upload'.tr();
  static String get discardVideoTitle => 'discard_video_title'.tr();
  static String get discardVideoMessage => 'discard_video_message'.tr();
  static String get discardChanges => 'discard_changes'.tr();
  static String get discardAndGoBack => 'discard_and_go_back'.tr();
  static String get megabyteUnit => 'megabyte_unit'.tr();
  static String get videoFileLabel => 'video_file_label'.tr();
  static String videoMetadata(String resolution, String duration) =>
      'video_metadata'.tr(
        args: {'resolution': resolution, 'duration': duration},
      );
  static String get videoPreview => 'video_preview'.tr();
  static String get transactionsTitle => 'transactions_title'.tr();
  static String get transactionsSubtitle => 'transactions_subtitle'.tr();
  static String get transactionsSearchHint => 'transactions_search_hint'.tr();
  static String get transactionsAll => 'transactions_all'.tr();
  static String get transactionsSuccess => 'transactions_success'.tr();
  static String get transactionsPending => 'transactions_pending'.tr();
  static String get transactionsFailed => 'transactions_failed'.tr();
  static String get transactionsOther => 'transactions_other'.tr();
  static String get transactionsToday => 'transactions_today'.tr();
  static String get transactionsYesterday => 'transactions_yesterday'.tr();
  static String get transactionsOlder => 'transactions_older'.tr();
  static String get transactionsCountZero => 'transactions_count_zero'.tr();
  static String get transactionsCountOne => 'transactions_count_one'.tr();
  static String transactionsCountValue(int count, String locale) => Intl.plural(
    count,
    locale: locale,
    zero: 'transactions_count_zero'.tr(),
    one: 'transactions_count_one'.tr(),
    two: 'transactions_count_two'.tr(args: {'count': '$count'}),
    few: 'transactions_count_few'.tr(args: {'count': '$count'}),
    many: 'transactions_count_many'.tr(args: {'count': '$count'}),
    other: 'transactions_count_other'.tr(args: {'count': '$count'}),
  );
  static String get transactionsFilter => 'transactions_filter'.tr();
  static String get transactionsMatched => 'transactions_matched'.tr();
  static String get transactionsUnmatched => 'transactions_unmatched'.tr();
  static String get transactionsPhoneUnavailable =>
      'transactions_phone_unavailable'.tr();
  static String get transactionsCopy => 'transactions_copy'.tr();
  static String get transactionsCopied => 'transactions_copied'.tr();
  static String get transactionsDetails => 'transactions_details'.tr();
  static String get transactionsSystemReference =>
      'transactions_system_reference'.tr();
  static String get transactionsTotalCollected =>
      'transactions_total_collected'.tr();
  static String get transactionsAmount => 'transactions_amount'.tr();
  static String get transactionsFullNumber => 'transactions_full_number'.tr();
  static String get transactionsCreatedAt => 'transactions_created_at'.tr();
  static String get transactionsPaymentMethod =>
      'transactions_payment_method'.tr();
  static String get transactionsIssuer => 'transactions_issuer'.tr();
  static String get transactionsPhone => 'transactions_phone'.tr();
  static String get transactionsReconciliation =>
      'transactions_reconciliation'.tr();
  static String get transactionsCurrency => 'transactions_currency'.tr();
  static String get transactionsNoData => 'transactions_no_data'.tr();
  static String get transactionsNoMatches => 'transactions_no_matches'.tr();
  static String get transactionsClearFilters =>
      'transactions_clear_filters'.tr();
  static String get transactionsReset => 'transactions_reset'.tr();
  static String get transactionsStatus => 'transactions_status'.tr();
  static String get transactionsSingleChoice =>
      'transactions_single_choice'.tr();
  static String get transactionsPaymentMethods =>
      'transactions_payment_methods'.tr();
  static String get transactionsMultipleChoice =>
      'transactions_multiple_choice'.tr();
  static String get transactionsDateRange => 'transactions_date_range'.tr();
  static String get transactionsLast7Days => 'transactions_last_7_days'.tr();
  static String get transactionsLast30Days => 'transactions_last_30_days'.tr();
  static String get transactionsCustomRange => 'transactions_custom_range'.tr();
  static String get transactionsSort => 'transactions_sort'.tr();
  static String get transactionsNewest => 'transactions_newest'.tr();
  static String get transactionsOldest => 'transactions_oldest'.tr();
  static String transactionsApplyFilters(int count) =>
      'transactions_apply_filters'.tr(args: {'count': '$count'});
  static String get transactionsRefresh => 'transactions_refresh'.tr();
  static String get transactionsMatchedSuccess =>
      'transactions_matched_success'.tr();
  static String get transactionsMatchedPending =>
      'transactions_matched_pending'.tr();
  static String get transactionsMatchedFailed =>
      'transactions_matched_failed'.tr();
  static String get transactionsCash => 'transactions_cash'.tr();
  static String get transactionsWallet => 'transactions_wallet'.tr();
  static String get transactionsBankCard => 'transactions_bank_card'.tr();
  static String get transactionsFawry => 'transactions_fawry'.tr();
  static String get transactionsDirectTransfer =>
      'transactions_direct_transfer'.tr();
  static String get transactionsCurrencyEgp => 'transactions_currency_egp'.tr();
  static String get transactionsCurrencySar => 'transactions_currency_sar'.tr();
  static String get transactionsUpdated => 'transactions_updated'.tr();
  static String get transactionsBankCardDetail =>
      'transactions_bank_card_detail'.tr();
  static String get transactionsShare => 'transactions_share'.tr();
  static String get transactionsSelectTransaction =>
      'transactions_select_transaction'.tr();
  static String get transactionsShareFailed => 'transactions_share_failed'.tr();
  static String get transactionsReconciliationRate =>
      'transactions_reconciliation_rate'.tr();
  static String get transactionsThisWeek => 'transactions_this_week'.tr();
  static String get transactionsSystemConnected =>
      'transactions_system_connected'.tr();
  static String get transactionsFinancialLedger =>
      'transactions_financial_ledger'.tr();
  static String get transactionsIssuerPaymob =>
      'transactions_issuer_paymob'.tr();
  static String get transactionsSystemConnecting =>
      'transactions_system_connecting'.tr();

  // Teacher Work Environment keys
  static String get searchCoursesHint => 'search_courses_hint'.tr();
  static String get addCourse => 'add_course'.tr();
  static String pendingWithdrawalAmount(String amount, String currency) =>
      'pending_withdrawal_amount'.tr(
        args: {'amount': amount, 'currency': currency},
      );
  static String filterAll(int count) =>
      'filter_all'.tr(args: {'count': '$count'});
  static String filterPublished(int count) =>
      'filter_published'.tr(args: {'count': '$count'});
  static String filterInReview(int count) =>
      'filter_in_review'.tr(args: {'count': '$count'});
  static String filterArchived(int count) =>
      'filter_archived'.tr(args: {'count': '$count'});
  static String get statusPublished => 'status_published'.tr();
  static String get statusInReview => 'status_in_review'.tr();
  static String get statusArchived => 'status_archived'.tr();
  static String get newCourseLabel => 'new_course_label'.tr();
  static String get freeCourseLabel => 'free_course_label'.tr();
  static String get noMatchingCourses => 'no_matching_courses'.tr();
  static String get noCoursesInFilter => 'no_courses_in_filter'.tr();
  static String get clearSearchAndFilters => 'clear_search_and_filters'.tr();

  static String get workspaceSummaryTitle => 'workspace_summary_title'.tr();
  static String get workspaceSummarySubtitle =>
      'workspace_summary_subtitle'.tr();
  static String get workspaceSummaryFailed => 'workspace_summary_failed'.tr();
  static String get workspaceRetry => 'workspace_retry'.tr();
  static String get kpiNewStudents => 'kpi_new_students'.tr();
  static String kpiChangeVsPrevious(String count) =>
      'kpi_change_vs_previous'.tr(args: {'count': count});
  static String get kpiChangeSame => 'kpi_change_same'.tr();
  static String get kpiNoNewStudents => 'kpi_no_new_students'.tr();
  static String get kpiNetEarnings => 'kpi_net_earnings'.tr();
  static String get kpiNetEarningsCaption => 'kpi_net_earnings_caption'.tr();
  static String get kpiAverageRating => 'kpi_average_rating'.tr();
  static String kpiRatingsFrom(String ratings) =>
      'kpi_ratings_from'.tr(args: {'ratings': ratings});
  static String get kpiNoRatings => 'kpi_no_ratings'.tr();
  static String get kpiTotalStudents => 'kpi_total_students'.tr();
  static String get attentionTitle => 'attention_title'.tr();
  static String get attentionAllClear => 'attention_all_clear'.tr();
  static String attentionShowAll(String count) =>
      'attention_show_all'.tr(args: {'count': count});
  static String get attentionShowLess => 'attention_show_less'.tr();
  static String get attentionDeclined => 'attention_declined'.tr();
  static String attentionCouponEnding(String code) =>
      'attention_coupon_ending'.tr(args: {'code': code});
  static String couponUsageProgress(String used, String limit) =>
      'coupon_usage_progress'.tr(args: {'used': used, 'limit': limit});
  static String get couponEndsToday => 'coupon_ends_today'.tr();
  static String get couponEndsTomorrow => 'coupon_ends_tomorrow'.tr();
  static String get couponEndsInTwoDays => 'coupon_ends_in_two_days'.tr();
  static String couponEndsInDays(String count) =>
      'coupon_ends_in_days'.tr(args: {'count': count});
  static String get statusDeclined => 'status_declined'.tr();
  static String get statusHiddenByAdmin => 'status_hidden_by_admin'.tr();
  static String get statusRemovedByAdmin => 'status_removed_by_admin'.tr();
  static String get statusUnknown => 'status_unknown'.tr();
  static String get attentionHiddenByAdmin => 'attention_hidden_by_admin'.tr();
  static String get attentionRemovedByAdmin =>
      'attention_removed_by_admin'.tr();
  static String get courseNoticeInReviewTitle =>
      'course_notice_in_review_title'.tr();
  static String get courseNoticeInReviewBody =>
      'course_notice_in_review_body'.tr();
  static String get courseNoticeDeclinedBody =>
      'course_notice_declined_body'.tr();
  static String get courseNoticeHiddenBody => 'course_notice_hidden_body'.tr();
  static String get courseNoticeRemovedBody =>
      'course_notice_removed_body'.tr();
  static String get courseEditReviewTitle => 'course_edit_review_title'.tr();
  static String get courseEditReviewBody => 'course_edit_review_body'.tr();
  static String get courseEditReviewConfirm =>
      'course_edit_review_confirm'.tr();
  static String get courseEditBlockedByAdmin =>
      'course_edit_blocked_by_admin'.tr();
  static String get secureContentAccessDenied =>
      'secure_content_access_denied'.tr();
  static String get secureFileNotAllowed => 'secure_file_not_allowed'.tr();
  static String get testAttemptRetry => 'test_attempt_retry'.tr();
  static String filterDeclined(int count) =>
      'filter_declined'.tr(args: {'count': '$count'});
  static String get courseAddFirstLesson => 'course_add_first_lesson'.tr();
  static String get coursesSortTooltip => 'courses_sort_tooltip'.tr();
  static String get coursesSortNewest => 'courses_sort_newest'.tr();
  static String get coursesSortMostStudents =>
      'courses_sort_most_students'.tr();
  static String get coursesSortTopRated => 'courses_sort_top_rated'.tr();

  static String kpiPublishedCourses(int count, String locale) {
    final formatted = LocaleFormatter.number(count, locale);
    return Intl.plural(
      count,
      locale: locale,
      zero: 'kpi_published_courses_zero'.tr(args: {'count': formatted}),
      one: 'kpi_published_courses_one'.tr(args: {'count': formatted}),
      two: 'kpi_published_courses_two'.tr(args: {'count': formatted}),
      few: 'kpi_published_courses_few'.tr(args: {'count': formatted}),
      many: 'kpi_published_courses_many'.tr(args: {'count': formatted}),
      other: 'kpi_published_courses_other'.tr(args: {'count': formatted}),
    );
  }

  static String attentionItemsCount(int count, String locale) {
    final formatted = LocaleFormatter.number(count, locale);
    return Intl.plural(
      count,
      locale: locale,
      zero: 'attention_items_zero'.tr(args: {'count': formatted}),
      one: 'attention_items_one'.tr(args: {'count': formatted}),
      two: 'attention_items_two'.tr(args: {'count': formatted}),
      few: 'attention_items_few'.tr(args: {'count': formatted}),
      many: 'attention_items_many'.tr(args: {'count': formatted}),
      other: 'attention_items_other'.tr(args: {'count': formatted}),
    );
  }

  static String attentionOpenReports(int count, String locale) {
    final formatted = LocaleFormatter.number(count, locale);
    return Intl.plural(
      count,
      locale: locale,
      zero: 'attention_open_reports_zero'.tr(args: {'count': formatted}),
      one: 'attention_open_reports_one'.tr(args: {'count': formatted}),
      two: 'attention_open_reports_two'.tr(args: {'count': formatted}),
      few: 'attention_open_reports_few'.tr(args: {'count': formatted}),
      many: 'attention_open_reports_many'.tr(args: {'count': formatted}),
      other: 'attention_open_reports_other'.tr(args: {'count': formatted}),
    );
  }

  static String attentionLowRatings(int count, String locale) {
    final formatted = LocaleFormatter.number(count, locale);
    return Intl.plural(
      count,
      locale: locale,
      zero: 'attention_low_ratings_zero'.tr(args: {'count': formatted}),
      one: 'attention_low_ratings_one'.tr(args: {'count': formatted}),
      two: 'attention_low_ratings_two'.tr(args: {'count': formatted}),
      few: 'attention_low_ratings_few'.tr(args: {'count': formatted}),
      many: 'attention_low_ratings_many'.tr(args: {'count': formatted}),
      other: 'attention_low_ratings_other'.tr(args: {'count': formatted}),
    );
  }

  static String cardOpenReports(int count, String locale) {
    final formatted = LocaleFormatter.number(count, locale);
    return Intl.plural(
      count,
      locale: locale,
      zero: 'card_open_reports_zero'.tr(args: {'count': formatted}),
      one: 'card_open_reports_one'.tr(args: {'count': formatted}),
      two: 'card_open_reports_two'.tr(args: {'count': formatted}),
      few: 'card_open_reports_few'.tr(args: {'count': formatted}),
      many: 'card_open_reports_many'.tr(args: {'count': formatted}),
      other: 'card_open_reports_other'.tr(args: {'count': formatted}),
    );
  }

  static String courseStudentsCount(int count, String locale) => Intl.plural(
    count,
    locale: locale,
    zero: 'course_students_zero'.tr(),
    one: 'course_students_one'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    two: 'course_students_two'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    few: 'course_students_few'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    many: 'course_students_many'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    other: 'course_students_other'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
  );

  static String courseLessonsCount(int count, String locale) => Intl.plural(
    count,
    locale: locale,
    zero: 'course_lessons_zero'.tr(),
    one: 'course_lessons_one'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    two: 'course_lessons_two'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    few: 'course_lessons_few'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    many: 'course_lessons_many'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    other: 'course_lessons_other'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
  );

  static String courseTestsCount(int count, String locale) => Intl.plural(
    count,
    locale: locale,
    zero: 'course_tests_zero'.tr(),
    one: 'course_tests_one'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    two: 'course_tests_two'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    few: 'course_tests_few'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    many: 'course_tests_many'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    other: 'course_tests_other'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
  );

  // Course ratings and reviews.
  static String get rateCourse => 'rate_course'.tr();
  static String get editYourRating => 'edit_your_rating'.tr();
  static String get yourReview => 'your_review'.tr();
  static String get ratingRequired => 'rating_required'.tr();
  static String get reviewTextHint => 'review_text_hint'.tr();
  static String get saveRating => 'save_rating'.tr();
  static String get deleteMyReview => 'delete_my_review'.tr();
  static String get deleteReviewConfirm => 'delete_review_confirm'.tr();
  static String get ratingSaved => 'rating_saved'.tr();
  static String get reviewDeleted => 'review_deleted'.tr();
  static String get noReviewsYet => 'no_reviews_yet'.tr();
  static String get noReviewsYetDescription =>
      'no_reviews_yet_description'.tr();
  static String get reviewsRetry => 'reviews_retry'.tr();
  static String get ratingSummaryUnavailable =>
      'rating_summary_unavailable'.tr();
  static String get ratingErrorNotSubscribed =>
      'rating_error_not_subscribed'.tr();
  static String get ratingErrorNotAllowed => 'rating_error_not_allowed'.tr();
  static String get ratingErrorInactiveAccount =>
      'rating_error_inactive_account'.tr();
  static String get ratingErrorCourseUnavailable =>
      'rating_error_course_unavailable'.tr();
  static String get ratingErrorTooFast => 'rating_error_too_fast'.tr();
  static String get ratingErrorBusy => 'rating_error_busy'.tr();
  static String get ratingErrorTextTooLong => 'rating_error_text_too_long'.tr();
  static String get ratingErrorAlreadyDeleted =>
      'rating_error_already_deleted'.tr();
  static String get ratingErrorSignIn => 'rating_error_sign_in'.tr();
  static String ratingOutOfFive(String rating) =>
      'rating_out_of_five'.tr(args: {'rating': rating});
  static String rateWithStars(int count) =>
      'rate_with_stars'.tr(args: {'count': '$count'});

  static String ratingsCount(int count, String locale) => Intl.plural(
    count,
    locale: locale,
    zero: 'ratings_count_zero'.tr(),
    one: 'ratings_count_one'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    two: 'ratings_count_two'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    few: 'ratings_count_few'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    many: 'ratings_count_many'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
    other: 'ratings_count_other'.tr(
      args: {'count': LocaleFormatter.number(count, locale)},
    ),
  );

  static String get tapStarToRate => 'tap_star_to_rate'.tr();

  static String get reviewNewLabel => 'review_new_label'.tr();
  static String get reviewsFilterNewest => 'reviews_filter_newest'.tr();
  static String get reviewsFilterLowest => 'reviews_filter_lowest'.tr();
  static String get reviewsLast30Days => 'reviews_last_30_days'.tr();
  static String get reviewsTrendUp => 'reviews_trend_up'.tr();
  static String get reviewsTrendDown => 'reviews_trend_down'.tr();
  static String get reviewsTrendSteady => 'reviews_trend_steady'.tr();
  static String get reviewsTrendFew => 'reviews_trend_few'.tr();
  static String get reviewsRecentNone => 'reviews_recent_none'.tr();
  static String get reviewsSinceLastVisit => 'reviews_since_last_visit'.tr();
  static String get reviewsNewMarkedHint => 'reviews_new_marked_hint'.tr();
  static String get reviewsFilterEmpty => 'reviews_filter_empty'.tr();
  static String get reviewsShowAll => 'reviews_show_all'.tr();
  static String get teacherReviewsEmptyDescription =>
      'teacher_reviews_empty_description'.tr();

  static String reviewsNewCount(
    int count,
    String locale, {
    bool partial = false,
  }) {
    final formatted = LocaleFormatter.number(count, locale);
    if (partial && count > 0) {
      return 'reviews_new_count_other'.tr(args: {'count': '$formatted+'});
    }
    return Intl.plural(
      count,
      locale: locale,
      zero: 'reviews_new_count_zero'.tr(),
      one: 'reviews_new_count_one'.tr(args: {'count': formatted}),
      two: 'reviews_new_count_two'.tr(args: {'count': formatted}),
      few: 'reviews_new_count_few'.tr(args: {'count': formatted}),
      many: 'reviews_new_count_many'.tr(args: {'count': formatted}),
      other: 'reviews_new_count_other'.tr(args: {'count': formatted}),
    );
  }

  static String get whatStudentsSay => 'what_students_say'.tr();
  static String get noOtherReviewsYet => 'no_other_reviews_yet'.tr();
  static String get reviewEdited => 'review_edited'.tr();
  static String get loadingReviews => 'loading_reviews'.tr();
  static String get rateCourseSubtitle => 'rate_course_subtitle'.tr();
  static String get beFirstToRate => 'be_first_to_rate'.tr();
  static String get editReview => 'edit_review'.tr();
  static String ratingLabel(int stars) =>
      'rating_label_${stars.clamp(1, 5)}'.tr();

  static String minutesAgo(int count, String locale) =>
      _timeAgo('minute', count, locale);
  static String hoursAgo(int count, String locale) =>
      _timeAgo('hour', count, locale);
  static String daysAgo(int count, String locale) =>
      _timeAgo('day', count, locale);

  static String _timeAgo(String unit, int count, String locale) {
    final args = {'count': LocaleFormatter.number(count, locale)};
    final many = 'report_time_${unit}_many'.tr(args: args);
    return Intl.plural(
      count,
      locale: locale,
      one: 'report_time_${unit}_one'.tr(args: args),
      two: 'report_time_${unit}_two'.tr(args: args),
      few: 'report_time_${unit}_few'.tr(args: args),
      many: many,
      other: many,
    );
  }

  static String priceEgpAmount(String amount) =>
      'price_egp_amount'.tr(args: {'amount': amount});
  static String recommendedForLevel(String level) =>
      'recommended_for_level'.tr(args: {'level': level});
  static String recommendedForSubject(String subject) =>
      'recommended_for_subject'.tr(args: {'subject': subject});
  static String get courseIncludes => 'course_includes'.tr();
  static String get lessonsLabel => 'lessons_label'.tr();
  static String get testsLabel => 'tests_label'.tr();
  static String get courseLevelLabel => 'course_level_label'.tr();
  static String get teachingLanguageLabel => 'teaching_language_label'.tr();
  static String get addDiscountCoupon => 'add_discount_coupon'.tr();
  static String get applyCoupon => 'apply_coupon'.tr();
  static String get removeCoupon => 'remove_coupon'.tr();
  static String couponDiscountApplied(String percent) =>
      'coupon_discount_applied'.tr(args: {'percent': percent});
  static String get paymentSummary => 'payment_summary'.tr();
  static String get coursePrice => 'course_price'.tr();
  static String get couponDiscountLine => 'coupon_discount_line'.tr();
  static String get checkoutTotal => 'checkout_total'.tr();
  static String get securePaymentPaymob => 'secure_payment_paymob'.tr();

  static String courseLevelName(String level) =>
      _labelFor(_courseLevelKeys, level);
  static String courseSubjectName(String subject) =>
      _labelFor(_courseSubjectKeys, subject);
  static String courseLanguageName(String language) =>
      _labelFor(_courseLanguageKeys, language);

  static String _labelFor(Map<String, String> keys, String value) {
    final key = keys[value.trim()];
    return key == null ? value : key.tr();
  }

  static const Map<String, String> _courseLevelKeys = {
    '1st Grade Primary': 'course_level_primary_1',
    '2nd Grade Primary': 'course_level_primary_2',
    '3rd Grade Primary': 'course_level_primary_3',
    '4th Grade Primary': 'course_level_primary_4',
    '5th Grade Primary': 'course_level_primary_5',
    '6th Grade Primary': 'course_level_primary_6',
    '1st Grade Preparatory': 'course_level_preparatory_1',
    '2nd Grade Preparatory': 'course_level_preparatory_2',
    '3rd Grade Preparatory': 'course_level_preparatory_3',
    '1st Grade Secondary': 'course_level_secondary_1',
    '2nd Grade Secondary': 'course_level_secondary_2',
    '3rd Grade Secondary': 'course_level_secondary_3',
  };

  static const Map<String, String> _courseSubjectKeys = {
    'Arabic': 'course_subject_arabic',
    'English': 'course_subject_english',
    'French': 'course_subject_french',
    'Italian': 'course_subject_italian',
    'Spanish': 'course_subject_spanish',
    'Mathematics': 'course_subject_mathematics',
    'Physics': 'course_subject_physics',
    'Chemistry': 'course_subject_chemistry',
    'Biology': 'course_subject_biology',
    'Biological Science': 'course_subject_biological_science',
    'Science': 'course_subject_science',
    'Philosophy': 'course_subject_philosophy',
    'History': 'course_subject_history',
    'Geography': 'course_subject_geography',
    'Computer Science': 'course_subject_computer_science',
    'Other': 'course_subject_other',
  };

  static const Map<String, String> _courseLanguageKeys = {
    'العربية': 'course_language_arabic',
    'Arabic': 'course_language_arabic',
    'English': 'course_language_english',
    'أخرى': 'course_language_other',
    'Other': 'course_language_other',
  };
  static String get tryAgain => 'try_again'.tr();
  static String get offlineBannerMessage => 'offline_banner_message'.tr();
  static String get connectionRestored => 'connection_restored'.tr();
  static String get offlineAutoRetryHint => 'offline_auto_retry_hint'.tr();
  static String get accountDeleteTitle => 'account_delete_title'.tr();
  static String get accountDeleteWarningTitle =>
      'account_delete_warning_title'.tr();
  static String get accountDeleteWarningBody =>
      'account_delete_warning_body'.tr();
  static String get accountDeleteRemovedTitle =>
      'account_delete_removed_title'.tr();
  static String get accountDeleteRemovedProfile =>
      'account_delete_removed_profile'.tr();
  static String get accountDeleteRemovedLearning =>
      'account_delete_removed_learning'.tr();
  static String get accountDeleteRemovedReviews =>
      'account_delete_removed_reviews'.tr();
  static String get accountDeleteRemovedSupport =>
      'account_delete_removed_support'.tr();
  static String get accountDeleteRemovedUnsoldCourses =>
      'account_delete_removed_unsold_courses'.tr();
  static String get accountDeleteKeptTitle => 'account_delete_kept_title'.tr();
  static String get accountDeleteKeptPayments =>
      'account_delete_kept_payments'.tr();
  static String get accountDeleteKeptSoldCourses =>
      'account_delete_kept_sold_courses'.tr();
  static String get accountDeletePayoutPendingTitle =>
      'account_delete_payout_pending_title'.tr();
  static String get accountDeletePayoutPending =>
      'account_delete_payout_pending'.tr();
  static String accountDeleteBalanceTitle(String amount) =>
      'account_delete_balance_title'.tr(args: {'amount': amount});
  static String get accountDeleteBalanceBody =>
      'account_delete_balance_body'.tr();
  static String get accountDeleteBalanceAcknowledge =>
      'account_delete_balance_acknowledge'.tr();
  static String get accountDeletePasswordLabel =>
      'account_delete_password_label'.tr();
  static String get accountDeleteGoogleNote =>
      'account_delete_google_note'.tr();
  static String get accountDeleteFacebookNote =>
      'account_delete_facebook_note'.tr();
  static String get accountDeleteSignInNote =>
      'account_delete_sign_in_note'.tr();
  static String get accountDeleteUnderstand => 'account_delete_understand'.tr();
  static String get accountDeleteButton => 'account_delete_button'.tr();
  static String get accountDeleteInProgress =>
      'account_delete_in_progress'.tr();
  static String get accountDeleteConfirmTitle =>
      'account_delete_confirm_title'.tr();
  static String get accountDeleteConfirmBody =>
      'account_delete_confirm_body'.tr();
  static String get accountDeleteDone => 'account_delete_done'.tr();
  static String get accountDeleteSignInAgain =>
      'account_delete_sign_in_again'.tr();
  static String get accountDeletePasswordRequired =>
      'account_delete_password_required'.tr();
  static String get accountReauthCancelled => 'account_reauth_cancelled'.tr();
  static String get accountReauthWrongAccount =>
      'account_reauth_wrong_account'.tr();
  static String get accountDeleteStaffBlocked =>
      'account_delete_staff_blocked'.tr();
  static String get accountDeleteBalanceRemaining =>
      'account_delete_balance_remaining'.tr();
  static String get accountDeletePaymentInProgress =>
      'account_delete_payment_in_progress'.tr();
  static String get accountDeleteIncomplete => 'account_delete_incomplete'.tr();
  static String get courseDeclineReasonLabel =>
      'course_decline_reason_label'.tr();
  static String courseDeclinedOn(String date) =>
      'course_declined_on'.tr(args: {'date': date});
  static String get courseResubmitButton => 'course_resubmit_button'.tr();
  static String get courseResubmitTitle => 'course_resubmit_title'.tr();
  static String get courseResubmitBody => 'course_resubmit_body'.tr();
  static String get courseResubmitDone => 'course_resubmit_done'.tr();
  static String get reviewActions => 'review_actions'.tr();
  static String get reviewReplyAction => 'review_reply_action'.tr();
  static String get reviewReplyEdit => 'review_reply_edit'.tr();
  static String get reviewReplyDelete => 'review_reply_delete'.tr();
  static String get reviewReplyTitle => 'review_reply_title'.tr();
  static String get reviewReplyEditTitle => 'review_reply_edit_title'.tr();
  static String get reviewReplyHint => 'review_reply_hint'.tr();
  static String get reviewReplyPlaceholder => 'review_reply_placeholder'.tr();
  static String get reviewReplyPublish => 'review_reply_publish'.tr();
  static String get reviewReplySaved => 'review_reply_saved'.tr();
  static String get reviewReplyDeleteTitle => 'review_reply_delete_title'.tr();
  static String get reviewReplyDeleteBody => 'review_reply_delete_body'.tr();
  static String get reviewReplyDeleted => 'review_reply_deleted'.tr();
  static String get reviewReplyEmpty => 'review_reply_empty'.tr();
  static String get reviewReplyTooLong => 'review_reply_too_long'.tr();
  static String get reviewTeacherReplyLabel =>
      'review_teacher_reply_label'.tr();
  static String get reviewReportAction => 'review_report_action'.tr();
  static String get reviewReportTitle => 'review_report_title'.tr();
  static String get reviewReportBody => 'review_report_body'.tr();
  static String get reviewReportReasonOffensive =>
      'review_report_reason_offensive'.tr();
  static String get reviewReportReasonHarassment =>
      'review_report_reason_harassment'.tr();
  static String get reviewReportReasonSpam => 'review_report_reason_spam'.tr();
  static String get reviewReportReasonPersonalInfo =>
      'review_report_reason_personal_info'.tr();
  static String get reviewReportReasonIrrelevant =>
      'review_report_reason_irrelevant'.tr();
  static String get reviewReportReasonOther =>
      'review_report_reason_other'.tr();
  static String get reviewReportDetailsHint =>
      'review_report_details_hint'.tr();
  static String get reviewReportSend => 'review_report_send'.tr();
  static String get reviewReportSent => 'review_report_sent'.tr();
  static String get reviewReportAlreadySent =>
      'review_report_already_sent'.tr();
  static String get reviewReportOwn => 'review_report_own'.tr();
  static String get reviewReportTooLong => 'review_report_too_long'.tr();
  static String get completeProfilePaymentSubtitle =>
      'complete_profile_payment_subtitle'.tr();
  static String get completeProfileLevelRequired =>
      'complete_profile_level_required'.tr();

  static String get completeProfileSave => 'complete_profile_save'.tr();
  static String get completeProfileSkip => 'complete_profile_skip'.tr();
  static String get completeProfileSaved => 'complete_profile_saved'.tr();
  static String get couponDeletedSuccessfully =>
      'coupon_deleted_successfully'.tr();
  static String get requiredSubscriptionData =>
      'required_subscription_data'.tr();
  static String get phoneNumberRequiredTitle =>
      'phone_number_required_title'.tr();
  static String get phoneNumberRequiredSubtitle =>
      'phone_number_required_subtitle'.tr();
  static String get selectedCourseLabel => 'selected_course_label'.tr();
  static String get registrationStepBadge => 'registration_step_badge'.tr();
  static String get requiredForContactAndPayment =>
      'required_for_contact_and_payment'.tr();
  static String get phoneUsageInfo => 'phone_usage_info'.tr();
  static String get saveAndContinueSubscription =>
      'save_and_continue_subscription'.tr();
  static String get goBack => 'go_back'.tr();
}
