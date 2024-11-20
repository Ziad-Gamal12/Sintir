// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/BottomNavigationBar_Entity.dart';
import 'package:sintir/Core/models/BottomNavigationBar_Model.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/CustomItem_BottomNavigationBar.dart';

class CustomBottomnavigationbar extends StatefulWidget {
  const CustomBottomnavigationbar({super.key, required this.onItemTapped});
  final ValueChanged<int> onItemTapped;
  @override
  State<CustomBottomnavigationbar> createState() =>
      _CustomBottomnavigationbarState();
}

class _CustomBottomnavigationbarState extends State<CustomBottomnavigationbar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 20),
        child: Row(
          children: BottomnavigationbarModel.toList().asMap().entries.map((e) {
            int index = e.key;
            BottomnavigationbarEntity bottomnavigationbarEntity = e.value;
            return Expanded(
              flex: currentIndex == index ? 5 : 2,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                  widget.onItemTapped(bottomnavigationbarEntity.index);
                },
                child: CustomItem_bottomnavigationbar(
                  isSelected: currentIndex == index ? true : false,
                  item: bottomnavigationbarEntity,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
