import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/Sections/TermsAndConditions_account_termination.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/Sections/TermsAndConditions_content_quality.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/Sections/TermsAndConditions_disclaimer.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/Sections/TermsAndConditions_laws.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/Sections/TermsAndConditions_payment_policy.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/Sections/TermsAndConditions_student_respect.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/Sections/TermsAndConditions_updates.dart';

class TeachertermsandconditionsviewBody extends StatelessWidget {
  const TeachertermsandconditionsviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Section1Laws(),
          const SizedBox(height: 16),
          Section2ContentQuality(),
          const SizedBox(height: 16),
          Section3StudentRespect(),
          const SizedBox(height: 16),
          Section4PaymentPolicy(),
          const SizedBox(height: 16),
          Section5AccountTermination(),
          const SizedBox(height: 16),
          Section6Updates(),
          const SizedBox(height: 16),
          Section7Disclaimer(),
        ],
      ),
    );
  }
}
