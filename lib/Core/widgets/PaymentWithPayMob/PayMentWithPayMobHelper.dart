import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayMentWithPayMobHelper {
  final PayMobResponse response;
  PayMentWithPayMobHelper({required this.response});
  late WebViewController controller;
  bool handledSuccess = false;

  void initPayment({required BuildContext context}) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            final url = request.url;
            if (url.contains("success=true") && !handledSuccess) {
              handledSuccess = true;
              TransactionEntity transaction = TransactionEntity(
                  amount: response.amount,
                  createdAt: DateTime.now(),
                  currency: response.currency,
                  isReconciled: false,
                  mobileNumber: response.mobileNumber,
                  transactionId: response.paymentid,
                  method: BackendEndpoints.payMentMethod,
                  issuer: "PayMob",
                  status: "Success");

              context.read<CourseSubscribtionsCubit>().subscribeToCourse(
                    amount: response.amount,
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
      ..loadRequest(Uri.parse(response.url));
  }
}
