import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CusstomCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/CustomCoursesInfoItemChild.dart';

class TeacherworkenvironmentcoursesInfo extends StatelessWidget {
  const TeacherworkenvironmentcoursesInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Cusstomcard(
              backgroundColor: Color(0xffF3F2F7),
              child: Customcoursesinfoitemchild(
                  title: "الكل", count: "20", textColor: Colors.black)),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Cusstomcard(
              backgroundColor: Color(0xff4BAE4F),
              child: Customcoursesinfoitemchild(
                  title: "تم النشر", count: "15", textColor: Colors.white)),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Cusstomcard(
              backgroundColor: Color(0xffFFC145),
              child: Customcoursesinfoitemchild(
                  title: "معلقة", count: "5", textColor: Colors.black)),
        ),
      ],
    );
  }
}
