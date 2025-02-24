import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomContentListViewitem.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';

class Coursedetailssectionspageviewitem extends StatelessWidget {
  const Coursedetailssectionspageviewitem(
      {super.key, required this.courseSectionsEntity});
  final List<CoursSectionsListItemEntity> courseSectionsEntity;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomListORGridTextHeader(
              text: "المحتوى",
              trailing: IntrinsicWidth(
                child: Custombutton(
                  text: "اضافة",
                  color: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {},
                  borderRadius: BorderRadius.zero,
                  side: const BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            courseSectionsEntity.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: courseSectionsEntity.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CustomContentListViewitem(
                        sectionItem: courseSectionsEntity[index],
                      );
                    },
                  )
                : const CustomEmptyWidget()
          ],
        )
      ],
    );
  }
}
