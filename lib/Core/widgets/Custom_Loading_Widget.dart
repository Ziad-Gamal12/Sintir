import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Custom_Loading_Widget extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const Custom_Loading_Widget(
      {super.key, required this.isLoading, required this.child});
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(inAsyncCall: isLoading, child: child);
  }
}
