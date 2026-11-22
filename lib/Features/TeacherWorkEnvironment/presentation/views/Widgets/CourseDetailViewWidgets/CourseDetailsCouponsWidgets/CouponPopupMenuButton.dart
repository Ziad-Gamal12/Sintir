import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/coupon_item_actions_cubit/coupon_item_actions_cubit.dart';

class CouponPopupMenuButton extends StatelessWidget {
  const CouponPopupMenuButton({
    super.key,
    required this.courseID,
    required this.couponID,
  });
  final String courseID, couponID;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<CouponItemActionsCubit, CouponItemActionsState, bool>(
      selector: (state) {
        if (state is DeleteCourseCouponLoading && state.couponId == couponID) {
          return true;
        }
        return false;
      },
      builder: (context, iSlaoding) {
        if (iSlaoding) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(strokeWidth: 1),
            ),
          );
        }
        return PopupMenuButton<String>(
          key: ValueKey('coupon-menu-$couponID'),
          onSelected: (String value) {
            if (value == 'delete') {
              context.read<CouponItemActionsCubit>().deleteCourseCoupon(
                courseID: courseID,
                couponID: couponID,
              );
            }
          },
          borderRadius: BorderRadius.circular(12),
          padding: EdgeInsetsGeometry.zero,
          position: PopupMenuPosition.under,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              key: ValueKey('coupon-delete-action'),
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 16),
                  SizedBox(width: 8),
                  Text('حذف'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
