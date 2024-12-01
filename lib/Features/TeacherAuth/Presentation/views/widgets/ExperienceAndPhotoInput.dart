// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/BlocBuilder/PhotoInputBlocBuilder.dart';

class ExperienceAndPhotoForm extends StatelessWidget {
  const ExperienceAndPhotoForm({
    super.key,
    required this.onPictureChanged,
  });
  final ValueChanged<String> onPictureChanged;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherSignUpCubit, TeacherSignUpState>(
        listener: (context, state) {
      if (state is UploadTeacherProfilePictureSuccess) {
        onPictureChanged(state.url);
        ShowSnackBar(
            context: context,
            child: ListTile(
              leading: const Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
              title: Text(
                "تم تحميل الصورة بنجاح",
                style:
                    AppTextStyles.semiBold13Auto.copyWith(color: Colors.white),
              ),
            ),
            backgroundColor: Colors.green);
      } else if (state is UploadTeacherProfilePictureFailure) {
        ShowSnackBar(
            context: context,
            child: ListTile(
              leading: const Icon(
                Icons.error,
                color: Colors.white,
              ),
              title: Text(
                state.errmessage,
                style:
                    AppTextStyles.semiBold13Auto.copyWith(color: Colors.white),
              ),
            ),
            backgroundColor: Colors.red);
      }
    }, builder: (context, state) {
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
            PhotoInputBlocBuilder(
              state: state,
            ),
          ],
        ),
      );
    });
  }
}
