import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/constant.dart';

class Addcoursesectionvedioviewbody extends StatelessWidget {
  const Addcoursesectionvedioviewbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: KHorizontalPadding, vertical: KVerticalPadding),
      child: Column(
        children: [
          Customteaxtfield(
              hintText: "يرجى كتابه أسم الفديو هنا ...",
              obscureText: false,
              textInputType: TextInputType.text,
              onSaved: (value) {
                context.read<Coursevedioitementity>().title = value!;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "ادخل اسم الفديو";
                }
                return null;
              }),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: const Center(child: Icon(FontAwesomeIcons.video)),
          ),
        ],
      ),
    );
  }
}
