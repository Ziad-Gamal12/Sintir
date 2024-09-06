import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTeaxtField.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';

class ExperienceAndPhotoInput extends StatefulWidget {
  final TeacherSignUpState state;
  const ExperienceAndPhotoInput({
    super.key,
    required this.state,
  });

  @override
  State<ExperienceAndPhotoInput> createState() =>
      _ExperienceAndPhotoInputState();
}

class _ExperienceAndPhotoInputState extends State<ExperienceAndPhotoInput> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Customteaxtfield(
              hintText: "عدد سنين الخبرة",
              prefixIcon: Icons.work_history_outlined,
              obscureText: false,
              controller: Variables.TeacherSignUpWorkExperienceController,
              textInputType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return "ادخل عدد سنين الخبرة الخاصة بك";
                }
                return null;
              }),
          const Customsizedbox(width: 0, height: 10),
          InkWell(
            onTap: () {
              context
                  .read<TeacherSignUpCubit>()
                  .uploadProfilePicture(source: ImageSource.gallery);
            },
            child: widget.state is UploadProfilePictureSuccess
                ? Container(
                    alignment: Alignment.center,
                    height: 40,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green, width: 1)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        const Customsizedbox(width: 5, height: 0),
                        Text(
                          "تم رفع الصورة بنجاح",
                          style: AppTextStyles.bold13
                              .copyWith(color: const Color(0xff818181)),
                        ),
                      ],
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    height: 40,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: (widget.state is UploadProfilePictureFailure)
                                ? Colors.red
                                : Colors.black,
                            width: 1)),
                    child: Row(
                      children: [
                        const Icon(Icons.upload),
                        Text(
                          "الصورة الشخصية",
                          style: AppTextStyles.bold13
                              .copyWith(color: const Color(0xff818181)),
                        ),
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
