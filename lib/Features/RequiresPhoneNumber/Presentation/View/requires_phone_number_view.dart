import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Features/RequiresPhoneNumber/Domain/Repos/UpdatePhoneNumberRepo.dart';
import 'package:sintir/Features/RequiresPhoneNumber/Presentation/Manager/UpdateUserPhoneNumberCubit/update_user_phone_number_cubit.dart';
import 'package:sintir/Features/RequiresPhoneNumber/Presentation/View/Widgets/RequiresPhoneNumberViewBody.dart';

class RequiresPhoneNumberView extends StatefulWidget {
  const RequiresPhoneNumberView({super.key, required this.courseName});

  final String courseName;
  static Future<T?> show<T>(
    BuildContext context, {
    required String courseName,
    TextEditingController? phoneController,
    bool isPhoneValid = false,
    VoidCallback? onSaveAndContinue,
    VoidCallback? onBack,
    VoidCallback? onClose,
    ValueChanged<String>? onPhoneChanged,
  }) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 600;

    if (isDesktop) {
      return showDialog<T>(
        context: context,
        barrierColor: Colors.black.withValues(alpha: 0.55),
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          child: RequiresPhoneNumberView(courseName: courseName),
        ),
      );
    }

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: RequiresPhoneNumberView(courseName: courseName),
      ),
    );
  }

  @override
  State<RequiresPhoneNumberView> createState() =>
      _RequiresPhoneNumberViewState();
}

class _RequiresPhoneNumberViewState extends State<RequiresPhoneNumberView> {
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UpdateUserPhoneNumberCubit(repo: getIt<UpdatePhoneNumberRepo>()),
      child: RequiresPhoneNumberViewBody(courseName: widget.courseName),
    );
  }
}
