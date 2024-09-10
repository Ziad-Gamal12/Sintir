import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/ResetPasswordPage.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/CustomButtonForGoogleApple.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/Student_text_rich.dart';

import '../../../../../Core/utils/Variables.dart';
import '../../../../../Core/utils/imageAssets.dart';
import '../../../../../Core/utils/textStyles.dart';
import '../../../../../Core/widgets/CustomButton.dart';
import '../../../../../Core/widgets/CustomSizedBox.dart';
import '../../../../../Core/widgets/CustomTeaxtField.dart';
import '../../../../../constant.dart';

class Studentbodyloginpage extends StatefulWidget {
  bool obscureText = true;
  Studentbodyloginpage({super.key});

  @override
  State<Studentbodyloginpage> createState() => _StudentbodyloginpageState();
}

class _StudentbodyloginpageState extends State<Studentbodyloginpage> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Column(
        children: [
          const Customsizedbox(
            width: 0,
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
            child: Customteaxtfield(
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
          ),
          const Customsizedbox(
            width: 0,
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
            child: Customteaxtfield(
              controller: Variables.StudentSigninPasswordController,
              hintText: 'كلمة المرور',
              prefixIcon: Icons.lock,
              obscureText: widget.obscureText,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                  icon: widget.obscureText
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
          ),
          const Customsizedbox(width: 0, height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    GoRouter.of(context).push(ResetPasswordPage.routeName);
                  },
                  child: Text('هل نسيت كلمة المرور ؟',
                      style: AppTextStyles.semiBold13Auto
                          .copyWith(color: KMainColor)),
                )
              ],
            ),
          ),
          const Customsizedbox(width: 0, height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 17, right: 15),
            child: Custombutton(
              color: const Color(0xff4169E2),
              onPressed: () {
                if (formState.currentState!.validate()) {}
              },
              text: 'تسجيل الدخول',
              textColor: Colors.white,
            ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
            child: Row(
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
          ),
          const Customsizedbox(
            width: 0,
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 11, right: 21),
            child: Custom_button(
                image: Assets.assetsImagesGoogle,
                text: 'تسجيل بواسطة جوجل',
                padding: 50,
                // icon: FontAwesomeIcons.google,
                logoColor: Colors.black),
          ),
          const Customsizedbox(
            width: 0,
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 11, right: 21),
            child: Custom_button(
              image: Assets.assetsImagesApple,
              padding: 60,
              text: 'تسجيل بواسطة أبل',
              // icon: FontAwesomeIcons.apple,
            ),
          ),
          const Customsizedbox(
            width: 0,
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 11, right: 21),
            child: Custom_button(
              image: Assets.assetsImagesSocialIcons,
              padding: 40,
              text: 'تسجيل بواسطة فيس بوك',
              // icon: FontAwesomeIcons.facebook,
              logoColor: Colors.blue[900],
            ),
          ),

          //border: 1px solid #
        ],
      ),
    );
  }
}
