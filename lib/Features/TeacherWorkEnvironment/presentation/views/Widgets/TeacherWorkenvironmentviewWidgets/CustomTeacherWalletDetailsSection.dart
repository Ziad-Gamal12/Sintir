import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomExpansionWIdget/CustomExpansionWidget.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/CustomTeacherWalletDetailsGridView.dart';
import 'package:sintir/constant.dart';

class CustomTeacherWalletDetailsSection extends StatelessWidget {
  const CustomTeacherWalletDetailsSection({super.key, required this.user});
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomExpansionWidget(
          title: "التفاصيل الخاصة بالمحفظة",
          content: Column(
            children: [
              CustomTeacherWalletDetailsGridView(
                teacherWalletEntity: user.teacherExtraDataEntity!.wallet,
              ),
              const SizedBox(
                height: 10,
              ),
              Custombutton(
                  text: "سحب رصيد",
                  color: KMainColor,
                  textColor: Colors.white,
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
