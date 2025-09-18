// ignore_for_file: file_names

import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:dropdown_model_list/drop_down/search_drop_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomstudentsignupSchoollevel extends StatefulWidget {
  const CustomstudentsignupSchoollevel(
      {super.key, required this.selectedOption});
  final ValueChanged<OptionItem> selectedOption;
  @override
  State<CustomstudentsignupSchoollevel> createState() =>
      CustomstudentsignupSchoollevelState();
}

class CustomstudentsignupSchoollevelState
    extends State<CustomstudentsignupSchoollevel> {
  OptionItem? optionItemSelected;
  TextEditingController controller = TextEditingController();
  var dropListModel = DropListModel([
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
      itemSelected: optionItemSelected ?? OptionItem(title: "المرحلة الدراسية"),
      dropListModel: dropListModel,
      showIcon: true,
      showArrowIcon: true,
      showBorder: true,
      icon: const Icon(
        Icons.approval,
        color: Colors.grey,
      ),
      textEditingController: controller,
      paddingTop: 0,
      suffixIcon: Icons.arrow_drop_down,
      containerPadding: const EdgeInsets.all(10),
      onOptionSelected: (optionItem) {
        optionItemSelected = optionItem;
        widget.selectedOption(optionItemSelected!);
        if (kDebugMode) {
          print(optionItemSelected!.id);
        }
        setState(() {});
      },
    );
  }
}
