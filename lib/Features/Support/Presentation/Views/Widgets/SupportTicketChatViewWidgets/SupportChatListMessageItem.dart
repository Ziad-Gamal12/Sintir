import 'package:flutter/material.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportChatMessageEntity.dart';

import 'SupportChatContent.dart';
import 'SupportChatHeader.dart';

class SupportChatListMessageItem extends StatelessWidget {
  final SupportChatMessageEntity messageEntity;
  final bool isMe;
  final VoidCallback? onLongPress;

  const SupportChatListMessageItem({
    super.key,
    required this.messageEntity,
    required this.isMe,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color bubbleColor = isMe
        ? theme.primaryColor
        : theme.colorScheme.surfaceContainerHighest.withOpacity(0.5);

    final Color textColor =
        isMe ? Colors.white : theme.colorScheme.onSurfaceVariant;
    final Color timeColor = isMe ? Colors.white70 : theme.colorScheme.outline;

    return GestureDetector(
      onLongPress: isMe ? onLongPress : null,
      child: Padding(
        padding: EdgeInsets.fromLTRB(isMe ? 16 : 6, 8, isMe ? 4 : 16, 6),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!isMe) SupportChatHeader(sender: messageEntity.sender),
            Material(
              borderRadius: _getBorderRadius(),
              clipBehavior: Clip.antiAlias,
              color: bubbleColor,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                child: SupportChatContent(
                  message: messageEntity,
                  isMe: isMe,
                  textColor: textColor,
                  timeColor: timeColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius() => BorderRadius.only(
        topLeft: const Radius.circular(16),
        topRight: const Radius.circular(16),
        bottomLeft: Radius.circular(isMe ? 16 : 4),
        bottomRight: Radius.circular(isMe ? 4 : 16),
      );
}
