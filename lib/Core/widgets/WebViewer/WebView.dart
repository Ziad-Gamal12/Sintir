import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/course_checkout_cubit/course_checkout_cubit.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Core/widgets/WebViewer/WebViewBody.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobWebViewRequirmentsEntity.dart';
import 'package:sintir/locale_keys.dart';

class Webviewer extends StatelessWidget {
  const Webviewer({super.key, required this.requirmentsEntity});
  static const routeName = '/WebView';
  final PayMobWebViewRequirmentsEntity requirmentsEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseCheckoutCubit(getIt<CourseCheckoutGateway>()),
      child: Scaffold(
        appBar: CustomAppBar(
          appBartitle: LocaleKeys.paymentStatusTitle,
          onBackPressed: () => Navigator.of(context).maybePop(),
        ),
        body: Webviewbody(
          response: requirmentsEntity.payMobResponse,
          courseTitle: requirmentsEntity.course.title,
          quote: requirmentsEntity.quote,
        ),
      ),
    );
  }
}
