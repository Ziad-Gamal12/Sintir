import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/Student_text_rich.dart';
import 'package:svg_flutter/svg.dart';
import '../../../../../Core/widgets/CustomButton.dart';
import '../../../../../Core/widgets/CustomTeaxtField.dart';
import '../widgets/CustomButtonForGoogleApple.dart';

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
            Icons.chevron_left,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          'تسجيل الدخول',
          style: TextStyle(
              fontWeight: AppTextStyles.bold19Auto.fontWeight,
              fontSize: AppTextStyles.bold19Auto.fontSize),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                  return 'يرجي ادخال الايميل';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
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
                if (value == null || value.isEmpty) {
                  return 'يرجي ادخال الايميل';
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 5),
                  child: InkWell(
                    onTap: () {},
                    child: Text('هل نسيت كلمة المرور ؟',
                        style: TextStyle(
                            fontWeight: AppTextStyles.bold13.fontWeight,
                            color: const Color(0xff4169E2))),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Custombutton(
              color: const Color(0xff4169E2),
              onPressed: () {},
              text: 'تسجيل الدخول',
              textColor: Colors.white,
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {},
              child: const StudentTextRich(
                text1: 'ليس لديك حساب؟',
                text2: 'قم بأنشاء حساب',
              ),
            ),
            const SizedBox(
              height: 50,
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
              height: 20,
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
              image: Assets.assetsImagesFacebook,
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
