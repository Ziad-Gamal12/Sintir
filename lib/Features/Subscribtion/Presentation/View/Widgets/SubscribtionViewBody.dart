import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/PayMobWebViewRequirmentsEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/WebViewer/WebView.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBodyActionButton.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBodyCouponTextField.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBodyCourseDetailsTitle.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBodyPhoneWalletTextField.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBodyPriceRow.dart';
import 'package:sintir/constant.dart';

class SubscribtionViewBody extends StatelessWidget {
  const SubscribtionViewBody({super.key, required this.requirmentsEntity});
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseSubscribtionsCubit, CourseSubscribtionsState>(
      listener: (context, state) {
        if (state is PayWithWalletSuccess) {
          GoRouter.of(context).push(Webviewer.routeName,
              extra: PayMobWebViewRequirmentsEntity(
                  course: requirmentsEntity.course,
                  payMobResponse: state.response));
        } else if (state is PayWithWalletFailure) {
          ShowErrorSnackBar(context: context, message: state.errMessage);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: KHorizontalPadding,
          vertical: KVerticalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Phone / Wallet Field
            const SubscribtionViewBodyPhoneWalletTextField(),

            Divider(
              color: Colors.grey.shade300,
              height: 60,
            ),

            /// Title
            const SubscribtionViewBodyCourseDetailsTitle(),

            const SizedBox(height: 20),

            /// Coupon Text Field
            const SubscribtionViewBodyCouponTextField(),

            const SizedBox(height: 20),

            /// Course Price Details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubscribtionViewBodyPriceRow(
                  icon: FontAwesomeIcons.dollarSign,
                  label: "السعر الاصلي: ",
                  value: "${requirmentsEntity.course.price} جنيه",
                ),
                const SizedBox(height: 10),
                SubscribtionViewBodyPriceRow(
                  icon: FontAwesomeIcons.dollarSign,
                  label: "السعر بعد الخصم: ",
                  value: "${requirmentsEntity.course.price} جنيه",
                ),
                const SizedBox(height: 10),
                const SubscribtionViewBodyPriceRow(
                  icon: FontAwesomeIcons.percent,
                  label: "نسبة الخصم: ",
                  value: "0 %",
                ),
              ],
            ),

            const Spacer(),

            /// Action Button
            const SubscribtionViewBodyActionButton(),
          ],
        ),
      ),
    );
  }
}
