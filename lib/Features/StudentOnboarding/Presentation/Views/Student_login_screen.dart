import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/Student_text_rich.dart';
import 'package:sintir/constant.dart';

import '../../../../Core/widgets/CustomButton.dart';
import '../../../../Core/widgets/CustomTeaxtField.dart';
import 'widgets/CustomButtonForGoogleApple.dart';

class StudentLoginPage extends StatefulWidget {
  static const String routeName = "/StudentLoginPage";

  const StudentLoginPage({super.key});

  @override
  State<StudentLoginPage> createState() => _StudentLoginPageState();
}

class _StudentLoginPageState extends State<StudentLoginPage> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text('تسجيل الدخول', style: AppTextStyles.bold19Auto),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: 12),
        child: Column(
          children: [
            Customteaxtfield(
              controller: Variables.StudentSigninEmailController,
              hintText: 'البريد الالكتروني',
              prefixIcon: Icons.email,
              obscureText: false,
              textInputType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجي ادخال البريد الالكتروني';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Customteaxtfield(
              controller: Variables.StudentSigninPasswordController,
              hintText: 'كلمة المرور',
              prefixIcon: Icons.lock,
              obscureText: _obscureText,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: _obscureText
                      ? const Icon(
                          Icons.visibility_off,
                          size: 24,
                          color: Color(0xffAEAEB2),
                        )
                      : const Icon(
                          Icons.visibility,
                          size: 24,
                          color: Color(0xffAEAEB2),
                        )),
              textInputType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'يرجي ادخال كلمة المرور';
                }
                return null;
              },
            ),
            const Customsizedbox(width: 0, height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: Text('هل نسيت كلمة المرور ؟',
                      style: AppTextStyles.semiBold13Auto
                          .copyWith(color: KMainColor)),
                )
              ],
            ),
            const Customsizedbox(width: 0, height: 30),
            Custombutton(
              color: const Color(0xff4169E2),
              onPressed: () {},
              text: 'تسجيل الدخول',
              textColor: Colors.white,
            ),
            const Customsizedbox(width: 0, height: 30),

            GestureDetector(
              onTap: () {},
              child: const StudentTextRich(
                text1: 'ليس لديك حساب؟',
                text2: 'قم بأنشاء حساب',
              ),
            ),
            const SizedBox(
              height: 55,
            ),
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: Color(0xffDDDFDF),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'أو',
                  style: TextStyle(
                      fontWeight: AppTextStyles.bold16Auto.fontWeight,
                      color: const Color(0xff141F1F)),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Divider(
                    color: Color(0xffDDDFDF),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Custom_button(
                image: Assets.assetsImagesGoogle,
                text: 'تسجيل بواسطة جوجل',
                padding: 50,
                // icon: FontAwesomeIcons.google,
                logoColor: Colors.black),
            const SizedBox(
              height: 15,
            ),
            const Custom_button(
              image: Assets.assetsImagesApple,
              padding: 60,
              text: 'تسجيل بواسطة أبل',
              // icon: FontAwesomeIcons.apple,
            ),
            const SizedBox(
              height: 15,
            ),
            Custom_button(
              image: Assets.assetsImagesSocialIcons,
              padding: 40,
              text: 'تسجيل بواسطة فيس بوك',
              // icon: FontAwesomeIcons.facebook,
              logoColor: Colors.blue[900],
            ),

            //border: 1px solid #
          ],
        ),
      ),
    );
  }
}
