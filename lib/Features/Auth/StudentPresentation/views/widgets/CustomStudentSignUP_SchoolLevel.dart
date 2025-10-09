// ignore_for_file: file_names

import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:dropdown_model_list/drop_down/search_drop_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

class CustomstudentsignupSchoollevel extends StatefulWidget {
  const CustomstudentsignupSchoollevel({
    super.key,
  });
  @override
  State<CustomstudentsignupSchoollevel> createState() =>
      CustomstudentsignupSchoollevelState();
}

class CustomstudentsignupSchoollevelState
    extends State<CustomstudentsignupSchoollevel> {
  OptionItem? optionItemSelected;
  TextEditingController controller = TextEditingController();
  DropListModel dropListModel = DropListModel([
    OptionItem(id: "1", title: "الصف الأول الأبتدائى"),
    OptionItem(id: "2", title: "الصف الثانى الأبتدائى"),
    OptionItem(id: "3", title: "الصف الثالث الأبتدائى"),
    OptionItem(id: "4", title: "الصف الرابع الأبتدائى"),
    OptionItem(id: "5", title: "الصف الخامس الأبتدائى"),
    OptionItem(id: "6", title: "الصف السادس الأبتدائى"),
    OptionItem(id: "7", title: "الصف الأول الأعدادى"),
    OptionItem(id: "9", title: "الصف الثانى الأعدادى"),
    OptionItem(id: "10", title: "الصف الثالث الأعدادى"),
    OptionItem(id: "11", title: "الصف الأول الثانوى"),
    OptionItem(id: "12", title: "الصف الثانى الثانوى"),
    OptionItem(id: "13", title: "الصف الثالث الثانوى"),
  ]);
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchDropList(
      paddingLeft: 0,
      paddingRight: 0,
      paddingBottom: 0,
      paddingTop: 0,
      itemSelected: optionItemSelected ?? OptionItem(title: "المرحلة الدراسية"),
      dropListModel: dropListModel,
      showIcon: true,
      showArrowIcon: true,
      showBorder: false,
      icon: const Icon(
        FontAwesomeIcons.userGraduate,
        color: Colors.grey,
      ),
      textEditingController: controller,
      suffixIcon: Icons.arrow_drop_down,
      containerPadding: const EdgeInsets.all(10),
      onOptionSelected: (optionItem) {
        optionItemSelected = optionItem;
        context.read<UserEntity>().studentExtraDataEntity?.educationLevel =
            optionItemSelected?.title ?? "";
        setState(() {});
      },
      containerDecoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      containerDecorationSearch: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      dropboxColor: Colors.grey.shade50,
      dropboxborderColor: Colors.grey.shade100,
    );
  }
}
