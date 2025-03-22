import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/Video%20Previewer%20Widgets/CustomDisplayingVedioWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/DisplayCourseVedioView_Widgets/CustomSendNoteText.dart';
import 'package:sintir/constant.dart';

class DisplaycoursevedioveiwBody extends StatelessWidget {
  const DisplaycoursevedioveiwBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Coursevedioitementity vedio = context.read<Coursevedioitementity>();

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CustomDisplayingVideoWidget(
                    videoUrl: vedio.vedioUrl,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomSendNoteText(),
                ],
              ),
            ),
          ],
        ));
  }
}
