import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/WebViewer/WebviewbodyPaymentSuccessWidget.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';
import 'package:sintir/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webviewbody extends StatefulWidget {
  const Webviewbody({super.key, required this.response});
  final PayMobResponse response;
  @override
  State<Webviewbody> createState() => _WebviewbodyState();
}

class _WebviewbodyState extends State<Webviewbody> {
  late WebViewController controller;
  bool handledSuccess = false;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            final url = request.url;

            if (url.contains("success=true") && !handledSuccess) {
              handledSuccess = true;
              TransactionEntity transaction = TransactionEntity(
                amount: widget.response.amount,
                method: BackendEndpoints.payMentMethod,
                createdAt: DateTime.now(),
                currency: widget.response.currency,
                isReconciled: false,
                issuer: widget.response.issuer,
                mobileNumber: widget.response.mobileNumber,
                status: "Success",
                transactionId: widget.response.paymentid,
              );
              context.read<CourseSubscribtionsCubit>().subscribeToCourse(
                    amount: widget.response.amount,
                    userEntity: getUserData(),
                    transactionEntity: transaction,
                  );
              return NavigationDecision.prevent;
            }

            if (url.contains("success=true") && handledSuccess) {
              return NavigationDecision.prevent;
            }

            if (url.contains("success=false")) {
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.response.url));

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
              child: Text(
            state.errMessge,
            style: AppTextStyles(context).bold24.copyWith(color: Colors.red),
          ));
        } else if (state is SubscibeingToCourseSuccess) {
          return const WebviewbodyPaymentSuccessWidget();
        }
        return WebViewWidget(controller: controller);
      },
    );
  }
}
