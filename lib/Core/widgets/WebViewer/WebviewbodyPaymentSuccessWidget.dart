import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class WebviewbodyPaymentSuccessWidget extends StatelessWidget {
  const WebviewbodyPaymentSuccessWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: AspectRatio(
              aspectRatio: 1,
              child: Lottie.asset(Assets.assetsLottieFilesSuccessanimation,
                  repeat: false, fit: BoxFit.fill),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "تم الاشتراك",
            style: AppTextStyles(context)
                .bold24
                .copyWith(color: const Color(0xff009ef2)),
          ),
        ],
      ),
    );
  }
}
