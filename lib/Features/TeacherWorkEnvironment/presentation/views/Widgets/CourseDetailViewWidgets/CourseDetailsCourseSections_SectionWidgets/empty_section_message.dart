import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

class EmptySectionMessage extends StatelessWidget {
  const EmptySectionMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        LocaleKeys.emptyContent,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }
}
