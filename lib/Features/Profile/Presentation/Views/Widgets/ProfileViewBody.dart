import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/LogOutDialog.dart';
import 'package:sintir/Features/Profile/Presentation/Manager/user_personal_details_cubit/user_personal_details_cubit.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileItemActionsButtons.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileViewBodyUserInfo.dart';
import 'package:sintir/constant.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserPersonalDetailsCubit, UserPersonalDetailsState>(
      listener: (context, state) {
        if (state is UpdatedUserProfilePicSuccess) {
          CustomSnackBar.show(context,
              message: "تم تغيير الصورة بنجاح", type: SnackType.success);
        } else if (state is UpdatedUserProfilePicFailure) {
          CustomSnackBar.show(context,
              message: state.errMessage, type: SnackType.error);
        }
      },
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: ProfileViewBodyUserInfo(),
            ),
            SliverToBoxAdapter(
              child: Divider(
                color: Colors.grey.shade300,
                height: 40,
              ),
            ),
            const SliverToBoxAdapter(
              child: ProfileItemActionsButtons(),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
            SliverToBoxAdapter(
              child: Custombutton(
                text: "تسجيل الخروج",
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => const LogoutDialog(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
