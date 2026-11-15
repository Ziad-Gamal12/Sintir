import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Helper/CourseDetailsCouponsViewHelper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseDetailsCouponsViewContent.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/coupon_item_actions_cubit/coupon_item_actions_cubit.dart';

class CourseDetailsCouponsViewBody extends StatefulWidget {
  const CourseDetailsCouponsViewBody({super.key, required this.courseId});

  final String courseId;

  @override
  State<CourseDetailsCouponsViewBody> createState() =>
      _CourseDetailsCouponsViewBodyState();
}

class _CourseDetailsCouponsViewBodyState
    extends State<CourseDetailsCouponsViewBody> {
  final ScrollController _scrollController = ScrollController();

  List<CourseCouponEntity> _coupons = [];
  bool _hasMore = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
    _fetchCoupons();
  }

  void _fetchCoupons() {
    context.read<CourseCouponsCubit>().getCourseCoupons(
      courseID: widget.courseId,
      isPaginate: false,
    );
  }

  void _onScroll() {
    _requestNextPageIfNeeded();
  }

  void _requestNextPageIfNeeded({bool allowWithoutScroll = false}) {
    final cubit = context.read<CourseCouponsCubit>();
    final hasClients = _scrollController.hasClients;

    final double? extentAfter = hasClients
        ? _scrollController.position.extentAfter
        : null;

    final shouldFetch = CourseDetailsCouponsViewHelper.shouldRequestNextPage(
      hasMore: _hasMore,
      isLoading: cubit.state is GetCourseCouponsLoading,
      hasScrollClients: hasClients,
      extentAfter: extentAfter,
      allowWithoutScroll: allowWithoutScroll,
    );

    if (!shouldFetch) return;

    cubit.getCourseCoupons(courseID: widget.courseId, isPaginate: true);
  }

  void _schedulePaginationCheck() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _requestNextPageIfNeeded(allowWithoutScroll: _coupons.isEmpty);
    });
  }

  void _handleCouponsState(BuildContext context, CourseCouponsState state) {
    if (state is GetCourseCouponsSuccess) {
      final response = state.response;

      final updatedCoupons = response.isPaginate
          ? CourseDetailsCouponsViewHelper.mergeUniqueCoupons(
              existing: _coupons,
              incoming: response.coupons,
            )
          : List<CourseCouponEntity>.of(response.coupons);

      setState(() {
        _coupons = updatedCoupons;
        _hasMore = response.hasMore;
      });

      _schedulePaginationCheck();
      return;
    }
    if (state is GetCourseCouponsFailure && _coupons.isNotEmpty) {
      CustomSnackBar.show(
        context,
        message: state.errmessage,
        type: SnackType.error,
      );
    }
  }

  void _handleCouponActionState(
    BuildContext context,
    CouponItemActionsState state,
  ) {
    if (state is DeleteCourseCouponSuccess) {
      final updatedCoupons = CourseDetailsCouponsViewHelper.removeCouponByCode(
        coupons: _coupons,
        code: state.couponId,
      );

      if (updatedCoupons.length == _coupons.length) return;

      setState(() {
        _coupons = updatedCoupons;
      });

      _schedulePaginationCheck();
      return;
    }

    if (state is DeleteCourseCouponFailure) {
      CustomSnackBar.show(
        context,
        message: state.errmessage,
        type: SnackType.error,
      );
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CourseCouponsCubit, CourseCouponsState>(
          listener: _handleCouponsState,
        ),
        BlocListener<CouponItemActionsCubit, CouponItemActionsState>(
          listener: _handleCouponActionState,
        ),
      ],
      child: BlocBuilder<CourseCouponsCubit, CourseCouponsState>(
        builder: (context, state) {
          return CourseDetailsCouponsViewContent(
            courseId: widget.courseId,
            coupons: _coupons,
            hasMore: _hasMore,
            scrollController: _scrollController,
            state: state,
          );
        },
      ),
    );
  }
}
