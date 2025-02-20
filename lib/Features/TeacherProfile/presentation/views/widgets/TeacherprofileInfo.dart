import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomIDWidget.dart';
import 'package:sintir/Core/widgets/CustomSettingsIcon.dart';
import 'package:sintir/Core/widgets/CustomSupportWidget.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/CustomTeacherLocation%20copy.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/CustomTeacherLocation.dart';

class TeacherprofileInfo extends StatelessWidget {
  const TeacherprofileInfo({super.key, required this.teacherentity});
  final teacherEntity teacherentity;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                  imageUrl: teacherentity.profilePicurl ?? "",
                  fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "${teacherentity.firstName} ${teacherentity.lastName}",
                  style:
                      AppTextStyles.semiBold14.copyWith(color: Colors.black)),
              const TextSpan(
                text: " ",
              ),
              TextSpan(
                  text: "(معلم)",
                  style: AppTextStyles.regular10
                      .copyWith(color: const Color(0xff818181)))
            ])),
            const SizedBox(
              height: 2,
            ),
            Customteacherlocation(
              location: teacherentity.address,
            ),
            const SizedBox(
              height: 2,
            ),
            CustomteacherSubject(
              subject: teacherentity.subject,
            ),
            const SizedBox(
              height: 2,
            ),
            Customidwidget(
              id: teacherentity.uid ?? "",
            ),
          ],
        ),
        const Spacer(),
        const Column(
          children: [
            Customsettingsicon(),
            SizedBox(
              height: 12,
            ),
            Customsupportwidget()
          ],
        )
      ],
    );
  }
}
