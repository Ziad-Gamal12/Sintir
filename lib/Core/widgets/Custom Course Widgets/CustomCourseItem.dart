// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomAddFavouriteIcon.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomContentCreatorCircleAvartar.dart';

class CustomCourseItem extends StatelessWidget {
  const CustomCourseItem(
      {super.key,
      required this.ontap,
      required this.courseItem,
      required this.isFavourite});
  final VoidCallback ontap;
  final CourseEntity courseItem;
  final bool isFavourite;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 8,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    child: SizedBox(
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: courseItem.posterUrl,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courseItem.title,
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.semiBold11
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            CustomContentCreatorCircleAvartar(
                              imagepath: courseItem
                                  .contentcreaterentity.profileImageUrl,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              courseItem.contentcreaterentity.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.regular10
                                  .copyWith(color: const Color(0xff818181)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              left: 8,
              child: CustomAddFavouriteIcon(
                isFavourite: isFavourite,
                ontap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
