// logout_dialog.dart
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/services/FireBase/FirebaseAuth_Service.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/ChoosingUserKindView.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 60),
        child: Text(
          "هل انت متأكد من تسجيل الخروج؟",
          style: AppTextStyles(
            context,
          )
              .semiBold14
              .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: Custombutton(
                onPressed: () async {
                  await firebaseAuthService().signout();
                  if (context.mounted) {
                    GoRouter.of(context).go(ChoosingUserKindView.routeName);
                  }
                },
                text: "تأكيد",
                color: Colors.red,
                textColor: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Custombutton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "لا أرغب",
                color: isDark ? Colors.grey.shade900 : Colors.white,
                textColor: Colors.black,
                side: const BorderSide(color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
