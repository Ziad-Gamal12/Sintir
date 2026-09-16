import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Core/widgets/PaymentWithPayMob/PayMentWithPayMobHelper.dart';
import 'package:sintir/Core/widgets/PaymentWithPayMob/WebviewbodyPaymentSuccessWidget.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';
import 'package:sintir/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWithPayMobBody extends StatefulWidget {
  const PaymentWithPayMobBody({super.key, required this.response});
  final PayMobResponse response;
  @override
  State<PaymentWithPayMobBody> createState() => _PaymentWithPayMobBodyState();
}

class _PaymentWithPayMobBodyState extends State<PaymentWithPayMobBody> {
  late PayMentWithPayMobHelper webHelper;
  @override
  void initState() {
    webHelper = PayMentWithPayMobHelper(response: widget.response);
    webHelper.initPayment(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseSubscribtionsCubit, CourseSubscribtionsState>(
      builder: (context, state) {
        if (state is SubscibeingToCourseLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: KMainColor,
          ));
        } else if (state is SubscibeingToCourseFailure) {
          return Center(
              child: CustomErrorWidget(errormessage: state.errMessge));
        } else if (state is SubscibeingToCourseSuccess) {
          return const WebviewbodyPaymentSuccessWidget();
        }
        return WebViewWidget(controller: webHelper.controller);
      },
    );
  }
}
