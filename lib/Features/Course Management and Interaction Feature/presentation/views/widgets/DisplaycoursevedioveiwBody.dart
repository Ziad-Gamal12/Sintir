import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomDisplayingVedioWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomSendNoteText.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/courseDetailsViewBodyContentsListView.dart';
import 'package:sintir/constant.dart';

class DisplaycoursevedioveiwBody extends StatelessWidget {
  DisplaycoursevedioveiwBody({super.key});

  String videoUrl = 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4';

  @override
  Widget build(BuildContext context) {
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
                  Customdisplayingvediowidget(
                    vedioUrl: videoUrl,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomSendNoteText(),
                  const SizedBox(
                    height: 25,
                  ),
                  const Divider(
                    height: 30,
                  ),
                  const Text("المحتوى",
                      textAlign: TextAlign.center, style: AppTextStyles.bold24),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            const Coursedetailsviewbodyvedioslistview(),
          ],
        ));
  }
}
