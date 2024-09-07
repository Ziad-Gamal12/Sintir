import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTeaxtField.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';

class ExperienceAndPhotoInput extends StatefulWidget {
  const ExperienceAndPhotoInput({
    super.key,
    required this.onPictureChanged,
  });
  final ValueChanged<String> onPictureChanged;

  @override
  State<ExperienceAndPhotoInput> createState() =>
      _ExperienceAndPhotoInputState();
}

class _ExperienceAndPhotoInputState extends State<ExperienceAndPhotoInput> {
  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeacherSignUpCubit, TeacherSignUpState>(
      listener: (context, state) {
        if (state is UploadTeacherProfilePictureSuccess) {
          widget.onPictureChanged(state.url);
          ShowSnackBar(
              context: context,
              child: ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
                title: Text(
                  "تم تحميل الصورة بنجاح",
                  style: AppTextStyles.semiBold13Auto
                      .copyWith(color: Colors.white),
                ),
              ),
              backgroundColor: Colors.green);
          setState(() {
            isLoading = false;
          });
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
                  style: AppTextStyles.semiBold13Auto
                      .copyWith(color: Colors.white),
                ),
              ),
              backgroundColor: Colors.red);
          setState(() {
            isLoading = false;
          });
        } else if (state is UploadTeacherProfilePictureLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: Expanded(
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
            isLoading
                ? const CircularProgressIndicator()
                : InkWell(
                    onTap: () {
                      context
                          .read<TeacherSignUpCubit>()
                          .uploadTeacherProfilePicture(
                              source: ImageSource.gallery);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 1)),
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
      ),
    );
  }
}
