import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomContainerSectionItem.dart';

class Customtestlistviewitem extends StatelessWidget {
  const Customtestlistviewitem({super.key, required this.item});
  final Coursetestentity item;
  @override
  Widget build(BuildContext context) {
    return Customcontainersectionitem(
        child: Customlisttilewidget(
            title: " ${item.title} ",
            image: item.preffixImage,
            subtitle: " (${item.durationTime} دقائق)",
            trailing: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                  width: 90,
                  child: Custombutton(
                    text: "بدأ الأمتحان",
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () => item.ontap(context: context, item: item),
                    child: const Icon(
                      Icons.key,
                      color: Colors.white,
                      size: 20,
                    ),
                  )),
            )));
  }
}
