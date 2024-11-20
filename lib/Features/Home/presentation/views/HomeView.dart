// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hidable/hidable.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/AI_Chat/presentation/views/aiChatView.dart';
import 'package:sintir/Features/Books_Library/Presentation/Views/EducationLevelsBooksSectionsView.dart';
import 'package:sintir/Features/Favorites/presentation/views/FavoritesView.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/Custom_BottomNavigationBar.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/Homeview_Body.dart';
import 'package:sintir/Features/tasks/presentation/views/todoListView.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});
  static const String routeName = '/HomeView';

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  int index = 0;

  List<Widget> pages = [
    Homeview_Body(),
    const Todolistview(),
    const Aichatview(),
    const EducationLevelsBooksSectionsView(),
    const Favoritesview(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Hidable(
        controller: Variables.scrollController,
        preferredWidgetSize: const Size.fromHeight(80),
        child: CustomBottomnavigationbar(
          onItemTapped: (value) {
            index = value;
            setState(() {});
          },
        ),
      ),
      body: SafeArea(child: pages[index]),
    );
  }
}
