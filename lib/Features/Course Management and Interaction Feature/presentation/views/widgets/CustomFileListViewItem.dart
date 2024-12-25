import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomContainerSectionItem.dart';

class Customfilelistviewitem extends StatelessWidget {
  const Customfilelistviewitem({super.key, required this.item});
  final Coursefileentity item;
  @override
  Widget build(BuildContext context) {
    return Customcontainersectionitem(
        child: Customlisttilewidget(
            title: " ${item.title} ",
            image: item.preffixImage,
            subtitle: " (${item.description})",
            trailing: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                  width: 90,
                  child: Custombutton(
                    text: "فتح الملف",
                    color: Colors.yellow.shade600,
                    textColor: Colors.white,
                    onPressed: () => item.ontap(context: context, item: item),
                    child: const Icon(
                      Icons.file_copy,
                      color: Colors.white,
                      size: 20,
                    ),
                  )),
            )));
  }
}
