import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Books_Library/Presentation/Views/widgets/LevelbooksviewBody.dart';

class Levelbooksview extends StatelessWidget {
  const Levelbooksview({super.key});
  static const String routeName = "/Levelbooksview";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBartitle: "الصف الثالث الأبتدائى"),
      body: LevelbooksviewBody(),
    );
  }
}
