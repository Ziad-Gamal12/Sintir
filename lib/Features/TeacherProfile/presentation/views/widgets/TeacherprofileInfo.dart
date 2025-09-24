import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomIDWidget.dart';
import 'package:sintir/Core/widgets/CustomSettingsIcon.dart';
import 'package:sintir/Core/widgets/CustomSupportWidget.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/CustomTeacherLocation%20copy.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/CustomTeacherLocation.dart';

class TeacherprofileInfo extends StatelessWidget {
  const TeacherprofileInfo({
    super.key,
  });
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
                  imageUrl: getUserData().profilePicurl, fit: BoxFit.cover),
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
                  text: "${getUserData().firstName} ${getUserData().lastName}",
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
              location: getUserData().address,
            ),
            const SizedBox(
              height: 2,
            ),
            CustomteacherSubject(
              subject: getUserData().teacherExtraDataEntity?.subject ?? "",
            ),
            const SizedBox(
              height: 2,
            ),
            Customidwidget(
              id: getUserData().uid,
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
