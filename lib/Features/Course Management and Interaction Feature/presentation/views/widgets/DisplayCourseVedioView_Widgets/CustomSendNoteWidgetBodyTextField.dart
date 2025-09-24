import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/VideoNoteEntity.dart';

class CustomSendNoteWidgetBodyTextField extends StatelessWidget {
  const CustomSendNoteWidgetBodyTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        maxLines: 4,
        hintText: "اكتب ملاحظتك هنا",
        obscureText: false,
        textInputType: TextInputType.text,
        onSaved: (val) {
          context.read<VideoNoteEntity>().note = val ?? "";
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "لا يمكن ان يكون الحقل فارغ";
          }
          return null;
        });
  }
}
