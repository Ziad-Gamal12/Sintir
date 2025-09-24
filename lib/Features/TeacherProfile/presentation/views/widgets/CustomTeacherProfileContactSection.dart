import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherProfile/domain/entities/customSocialLinksItemEntity.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/customContactItem.dart';

class Customteacherprofilecontactsection extends StatelessWidget {
  const Customteacherprofilecontactsection(
      {super.key, required this.socailLinks});
  final List<Customsociallinksitementity> socailLinks;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: socailLinks.isEmpty ? false : true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: socailLinks.map((e) {
          return Customcontactitem(image: e.imageURL, title: e.text);
        }).toList()),
      ),
    );
  }
}
