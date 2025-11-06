import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
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
  bool handledSuccess = false; // flag to know if success handled before

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            final url = request.url;

            // لو أول مرة نشوف success=true
            if (url.contains("success=true") && !handledSuccess) {
              handledSuccess = true; // قفلنا العلم
              context.read<CourseSubscribtionsCubit>().subscribeToCourse(
                    amount: widget.response.amount,
                    userEntity: getUserData(),
                    transactionId: widget.response.paymentid,
                  );
              return NavigationDecision.prevent; // امنع التنقل
            }

            // لو فيه success=true تاني → تجاهل (يسمح بالـ navigation عادي)
            if (url.contains("success=true") && handledSuccess) {
              return NavigationDecision
                  .prevent; // امنع كمان عشان مفيش داعي يفتح لينك success تاني
            }

            // لو success=false → ممكن تمنع أو تسمح حسب اللي تحب
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
