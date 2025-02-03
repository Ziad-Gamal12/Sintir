// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/BlocBuilder/PhotoInputBlocBuilder.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/TeacherAuthListeners/teacherBlocListenerMethods.dart';

class ExperienceAndPhotoForm extends StatelessWidget {
  const ExperienceAndPhotoForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherSignUpCubit, TeacherSignUpState>(
        listener: (context, state) {
      teacherSignUpViewBodyUplaodPicListener(
        state,
        context,
      );
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
