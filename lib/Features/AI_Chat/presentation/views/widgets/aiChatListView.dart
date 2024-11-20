import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/AI_Chat/domain/entities/messageEntity.dart';
import 'package:sintir/Features/AI_Chat/presentation/views/widgets/aiChatListViewItem.dart';
import 'package:sintir/constant.dart';

class Aichatlistview extends StatelessWidget {
  Aichatlistview({super.key});
  List messages = [
    Messageentity(message: "hello my freind ", isUserMessage: true),
    Messageentity(message: "Hey Ziad! How's it going?", isUserMessage: false),
    Messageentity(message: "All good, how about you?", isUserMessage: true),
    Messageentity(
        message: "I'm doing great, thanks for asking! What's up?",
        isUserMessage: false),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: Variables.scrollController,
        padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          bool isUserMessage = messages[index].isUserMessage;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Align(
              alignment:
                  isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
              child: Aichatlistviewitem(
                message: messages[index].message,
                isUserMessage: isUserMessage,
              ),
            ),
          );
        });
  }
}
