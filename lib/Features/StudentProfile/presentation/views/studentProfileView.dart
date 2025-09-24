import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/StudentProfile/presentation/views/widgets/StudentprofileviewBody.dart';

class Studentprofileview extends StatefulWidget {
  const Studentprofileview({super.key});
  static const routeName = '/Studentprofileview';

  @override
  State<Studentprofileview> createState() => _StudentprofileviewState();
}

class _StudentprofileviewState extends State<Studentprofileview> {
  @override
  void initState() {
    // context.read<UserCubit>().getUsersCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBartitle: "الملف الشخصى"),
      body: StudentprofileviewBody(),
    );
  }
}
