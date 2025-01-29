import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/addFirstContentItem.dart';

class Addcoursefirstcontentoptionslist extends StatelessWidget {
  const Addcoursefirstcontentoptionslist({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Addfirstcontentitem(
            image: Assets.assetsImagesAddCourseVedioIcon,
            title: "رفع فديو",
            subtitle:
                "يمكنك رفع فيديو من الفيديوهات الخاصة بالدورة (يفضل فديو تعريفى)"),
        SizedBox(
          height: 10,
        ),
        Addfirstcontentitem(
            image: Assets.assetsImagesAddCoursePictureIcon,
            title: "رفع صورة",
            subtitle:
                "يمكنك رفع صورة من الصور الخاصة بالدورة (يفضل صورة تعريفى)"),
        SizedBox(
          height: 10,
        ),
        Addfirstcontentitem(
          image: Assets.assetsImagesAddCourseTextIcon,
          title: "رفع نص",
          subtitle: "يمكنك رفع نص من الصور الخاصة بالدورة",
        )
      ],
    );
  }
}
