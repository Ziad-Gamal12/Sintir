// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class CustomChatTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;
  final VoidCallback onPressed;
  bool? isLoading;
  CustomChatTextField(
      {super.key,
      this.inputFormatters,
      required this.onPressed,
      this.isLoading,
      required this.controller,
      required this.validator});

  @override
  State<CustomChatTextField> createState() => _CustomChatTextFieldState();
}

class _CustomChatTextFieldState extends State<CustomChatTextField> {
  bool isChatTextFieldEmpty = true;
  getisChatTextFieldEmpty() {
    widget.controller.addListener(() {
      setState(() {
        isChatTextFieldEmpty = widget.controller.text.isEmpty;
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getisChatTextFieldEmpty();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20));
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          spreadRadius: 5,
          blurRadius: 10,
          offset: const Offset(0, 8),
        ),
      ]),
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        keyboardType: TextInputType.text,
        obscureText: false,
        validator: widget.validator,
        decoration: InputDecoration(
            hintText: "أكتب رسالتك هنا...",
            hintStyle: AppTextStyles(context)
                .bold13
                .copyWith(color: Colors.grey.shade500),
            suffixIcon: widget.isLoading == true
                ? const CircularProgressIndicator(
                    color: KMainColor,
                  )
                : IconButton(
                    icon: Icon(
                      FontAwesomeIcons.paperPlane,
                      size: 24,
                      color: isChatTextFieldEmpty == true
                          ? const Color(0xffAEAEB2)
                          : Colors.black,
                    ),
                    onPressed: () {
                      widget.onPressed();
                    },
                  ),
            border: border,
            focusedBorder: border,
            enabledBorder: border,
            filled: true,
            focusColor: const Color(0xfff4f4f4),
            fillColor: const Color(0xfff4f4f4)),
      ),
    );
  }
}
