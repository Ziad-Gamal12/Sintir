import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseFedBack_Widgets/CourseFedBacksListView_item.dart';
import 'package:sintir/constant.dart';

class Coursefedbackslistview extends StatelessWidget {
  const Coursefedbackslistview(
      {super.key,
      required this.courseFedBacks,
      required this.scrollController});
  final List courseFedBacks;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseFeedBacksCubit, CourseFeedBacksState>(
      builder: (context, state) {
        if (state is CourseFeedBacksGetFeedBackLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: KMainColor,
          ));
        } else if (state is CourseFeedBacksGetFeedBackFailure) {
          return Center(
            child: CustomErrorWidget(errormessage: state.errMessage),
          );
        }
        return ListView.builder(
            controller: scrollController,
            itemCount: courseFedBacks.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CoursefedbackslistviewItem(item: courseFedBacks[index]),
              );
            });
      },
    );
  }
}
