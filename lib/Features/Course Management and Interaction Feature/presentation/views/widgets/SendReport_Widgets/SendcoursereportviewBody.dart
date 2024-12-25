import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/SendReport_Widgets/CustomHeader.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/SendReport_Widgets/SendReportReasonsGridView.dart';
import 'package:sintir/constant.dart';

class Sendcoursereportviewbody extends StatefulWidget {
  const Sendcoursereportviewbody({
    super.key,
  });

  @override
  State<Sendcoursereportviewbody> createState() =>
      _SendcoursereportviewbodyState();
}

class _SendcoursereportviewbodyState extends State<Sendcoursereportviewbody> {
  String reportReson = "";
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 20),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: CustomHeader(title: "أسباب الابلاغ :"),
          ),
          Sendreportreasonsgridview(
            groupValue: reportReson,
            onChange: (value) {
              reportReson = value.toString();
              setState(() {});
            },
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const CustomHeader(title: "وصف الابلاغ :"),
                const SizedBox(
                  height: 20,
                ),
                Customteaxtfield(
                    maxLines: 4,
                    hintText: "اكتب ملاحظتك هنا ....",
                    obscureText: false,
                    controller: controller,
                    textInputType: TextInputType.text,
                    validator: (value) {
                      return null;
                    }),
                const Spacer(),
                Custombutton(
                    text: "ارسال الأبلاغ",
                    color: KSecondaryColor,
                    textColor: Colors.white,
                    onPressed: () {})
              ],
            ),
          )
        ],
      ),
    );
  }
}
