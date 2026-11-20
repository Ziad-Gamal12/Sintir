import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/course_checkout_cubit/course_checkout_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ProfileCompleteness.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/course_price_formatter.dart';
import 'package:sintir/Core/widgets/WebViewer/WebView.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Entities/CompleteProfilePurpose.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Views/CompleteProfileView.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/CourseCheckoutEntity.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobWebViewRequirmentsEntity.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/CheckoutBottomBar.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/CheckoutCouponSection.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/CheckoutCourseSummaryCard.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/CheckoutIncludesSection.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/CheckoutPriceBreakdown.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/ExistingCheckoutDialog.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class SubscribtionViewBody extends StatefulWidget {
  const SubscribtionViewBody({
    super.key,
    required this.requirmentsEntity,
    this.readCurrentUser,
    this.openProfileCompletion,
  });

  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  final UserEntity Function()? readCurrentUser;
  final Future<bool?> Function(BuildContext context)? openProfileCompletion;

  @override
  State<SubscribtionViewBody> createState() => _SubscribtionViewBodyState();
}

class _SubscribtionViewBodyState extends State<SubscribtionViewBody> {
  CourseCheckoutQuote? _quote;
  bool _quoting = false;
  String? _couponError;

  CourseEntity get _course => widget.requirmentsEntity.course;

  void _applyCoupon(String code) {
    setState(() {
      _quoting = true;
      _couponError = null;
    });
    context.read<CourseCheckoutCubit>().quote(_course.id, couponCode: code);
  }

  void _removeCoupon() {
    setState(() {
      _quote = null;
      _couponError = null;
    });
  }

  UserEntity? _currentUser() {
    try {
      return (widget.readCurrentUser ?? getUserData)();
    } catch (_) {
      return null;
    }
  }

  Future<bool> _completeProfileForPayment() async {
    //navigate to a new screen
    final open =
        widget.openProfileCompletion ??
        (context) => context.push<bool>(CompleteProfileView.routeName);
    final completed = await open(context);
    return completed == true && mounted;
  }

  Future<void> _subscribe() async {
    final user = _currentUser();
    if (user != null &&
        ProfileCompleteness.missingForPayment(user).isNotEmpty &&
        !await _completeProfileForPayment()) {
      return;
    }
    if (!mounted) return;
    _startPayment();
  }

  void _startPayment() {
    context.read<CourseCheckoutCubit>().createPayment(
      _course.id,
      couponCode: _quote?.couponCode,
    );
  }

  Future<void> _retryAfterBillingFix() async {
    if (await _completeProfileForPayment()) _startPayment();
  }

  void _onCheckoutState(BuildContext context, CourseCheckoutState state) {
    if (state is CourseCheckoutCreated) {
      _openAttempt(context, _course, state.attempt);
    } else if (state is CourseCheckoutQuoteReady) {
      setState(() {
        _quoting = false;
        _couponError = null;
        _quote = state.quote.couponCode == null ? null : state.quote;
      });
    } else if (state is CourseCheckoutFailure &&
        state.code == 'billing_phone_missing' &&
        !_quoting) {
      _retryAfterBillingFix();
    } else if (state is CourseCheckoutFailure) {
      if (_quoting) {
        setState(() {
          _quoting = false;
          _quote = null;
          _couponError = state.message;
        });
      } else {
        CustomSnackBar.show(
          context,
          message: state.message,
          type: SnackType.error,
        );
      }
    } else if (state is CourseCheckoutRecoveryRequired) {
      setState(() => _quoting = false);
      CustomSnackBar.show(
        context,
        message: state.message,
        type: SnackType.info,
      );
    } else if (state is CourseCheckoutReviewRequired) {
      setState(() => _quoting = false);
      CustomSnackBar.show(
        context,
        message: state.message,
        type: SnackType.warning,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final course = _course;
    final locale = Localizations.localeOf(context).languageCode;
    final quote = _quote;
    final originalCents = quote?.originalAmountCents ?? course.price * 100;
    final discountCents = quote?.discountAmountCents ?? 0;
    final totalCents = quote?.amountCents ?? course.price * 100;
    final hasDiscount = discountCents > 0;

    return BlocListener<CourseCheckoutCubit, CourseCheckoutState>(
      listener: _onCheckoutState,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                KHorizontalPadding,
                8,
                KHorizontalPadding,
                24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CheckoutCourseSummaryCard(course: course),
                  const SizedBox(height: 24),
                  CheckoutIncludesSection(course: course),
                  const SizedBox(height: 16),
                  CheckoutCouponSection(
                    appliedCode: quote?.couponCode,
                    discountPercent: quote?.discountPercentage ?? 0,
                    isApplying: _quoting,
                    errorText: _couponError,
                    onApply: _applyCoupon,
                    onRemove: _removeCoupon,
                  ),
                  if (hasDiscount) ...[
                    const SizedBox(height: 16),
                    CheckoutPriceBreakdown(
                      originalCents: originalCents,
                      discountCents: discountCents,
                      totalCents: totalCents,
                    ),
                  ],
                ],
              ),
            ),
          ),
          CheckoutBottomBar(
            totalText: totalCents <= 0
                ? LocaleKeys.free
                : CoursePriceFormatter.fromCents(totalCents, locale),
            originalText: hasDiscount
                ? CoursePriceFormatter.fromCents(originalCents, locale)
                : null,
            isQuoting: _quoting,
            onPressed: _subscribe,
          ),
        ],
      ),
    );
  }

  Future<void> _openAttempt(
    BuildContext context,
    CourseEntity course,
    CoursePaymentAttempt attempt,
  ) async {
    if (attempt.requiresConfirmation) {
      final action = await showDialog<ExistingCheckoutAction>(
        context: context,
        builder: (_) => ExistingCheckoutDialog(
          courseTitle: course.title,
          attempt: attempt,
          requestDiffers: attempt.requestDiffers,
        ),
      );
      if (action == null ||
          action == ExistingCheckoutAction.checkLater ||
          !context.mounted) {
        return;
      }
      final checkoutUrl = action == ExistingCheckoutAction.resumePayment
          ? attempt.checkoutUrl
          : '';
      await _openVerification(context, course, attempt, checkoutUrl);
      return;
    }
    if (!context.mounted) return;
    await _openVerification(context, course, attempt, attempt.checkoutUrl);
  }

  Future<void> _openVerification(
    BuildContext context,
    CourseEntity course,
    CoursePaymentAttempt attempt,
    String checkoutUrl,
  ) async {
    final completed = await context.push<bool>(
      Webviewer.routeName,
      extra: PayMobWebViewRequirmentsEntity(
        course: course,
        payMobResponse: PayMobResponse(
          url: checkoutUrl,
          paymentAttemptId: attempt.id,
          status: attempt.status,
        ),
        quote: attempt.quote,
      ),
    );
    if (completed == true && context.mounted) {
      widget.requirmentsEntity
        ..isSubscribed = true
        ..hasSubscriptionCheckResult = true;
      context.pop(true);
    }
  }
}
