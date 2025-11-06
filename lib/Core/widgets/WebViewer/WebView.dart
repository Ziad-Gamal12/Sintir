import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/repos/PaymobRepo.dart/PaymobRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Core/widgets/WebViewer/WebViewBody.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobWebViewRequirmentsEntity.dart';

class Webviewer extends StatelessWidget {
  const Webviewer({super.key, required this.requirmentsEntity});
  static const routeName = '/WebView';
  final PayMobWebViewRequirmentsEntity requirmentsEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseSubscribtionsCubit(
        paymobRepo: getIt<PaymobRepo>(),
        subscribtionRepo: getIt<CourseSubscibtionsRepo>(),
        course: requirmentsEntity.course,
      ),
      child: Scaffold(
        appBar: const CustomAppBar(appBartitle: "الموقع الالكتروني"),
        body: Webviewbody(response: requirmentsEntity.payMobResponse),
      ),
    );
  }
}
