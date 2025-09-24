// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/Sections/TermsAndConditions_account_termination.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/Sections/TermsAndConditions_content_quality.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/Sections/TermsAndConditions_disclaimer.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/Sections/TermsAndConditions_laws.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/Sections/TermsAndConditions_payment_policy.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/Sections/TermsAndConditions_student_respect.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/Sections/TermsAndConditions_updates.dart';

class TeachertermsandconditionsviewBody extends StatelessWidget {
  const TeachertermsandconditionsviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Section1Laws(),
          SizedBox(height: 16),
          Section2ContentQuality(),
          SizedBox(height: 16),
          Section3StudentRespect(),
          SizedBox(height: 16),
          Section4PaymentPolicy(),
          SizedBox(height: 16),
          Section5AccountTermination(),
          SizedBox(height: 16),
          Section6Updates(),
          SizedBox(height: 16),
          Section7Disclaimer(),
        ],
      ),
    );
  }
}
