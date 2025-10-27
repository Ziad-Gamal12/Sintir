import 'package:flutter/material.dart';

class EmptySectionMessage extends StatelessWidget {
  const EmptySectionMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "لا توجد عناصر بعد، قم بإضافة عنصر جديد.",
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}
