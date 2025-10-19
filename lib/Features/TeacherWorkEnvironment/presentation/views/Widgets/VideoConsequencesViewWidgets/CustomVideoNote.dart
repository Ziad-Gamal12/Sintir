import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/Core/widgets/CustomCard.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/VideoNoteEntity.dart';

class CustomVideoNote extends StatelessWidget {
  const CustomVideoNote({super.key, required this.note});
  final VideoNoteEntity note;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(40),
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CustomCachedNetworkImage(
                        imageUrl: note.user.profilePicurl),
                  )),
            ),
            title: Text(
              "${note.user.firstName} ${note.user.lastName}",
              style: AppTextStyles(context).semiBold16,
            ),
            subtitle: Text(
              "${note.dateTime.day}/${note.dateTime.month}/${note.dateTime.year}",
              style: AppTextStyles(context).regular13,
            )),
        const SizedBox(
          height: 5,
        ),
        Text(
          note.note,
          style: AppTextStyles(context).regular14,
        )
      ],
    ));
  }
}
