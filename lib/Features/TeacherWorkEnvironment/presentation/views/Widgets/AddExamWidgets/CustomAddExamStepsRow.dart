import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CustomAddExamStepsRowItemEntity.dart';

class CustomAddExamStepsRow extends StatelessWidget {
  const CustomAddExamStepsRow({
    super.key,
    required this.pageController,
    required this.currentStep,
  });

  final PageController pageController;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = CustomAddExamStepsRowItemEntity.toList();
    final primaryColor = theme.primaryColor;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
        border: Border.all(color: theme.dividerColor.withOpacity(0.05)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildDynamicTrack(context, items.length, primaryColor),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: items.asMap().entries.map((e) {
                  final bool isCompleted = e.key < currentStep;
                  final bool isSelected = currentStep == e.key;
                  return GestureDetector(
                    onTap: () {
                      if (e.key <= currentStep) {
                        pageController.animateToPage(
                          e.key,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutQuint,
                        );
                      }
                    },
                    child: SizedBox(
                      width: 120,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildNode(
                              isCompleted, isSelected, primaryColor, theme),
                          const SizedBox(height: 12),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? primaryColor
                                  : (isCompleted
                                      ? theme.textTheme.bodyLarge?.color
                                      : Colors.grey),
                            ),
                            child: Text(e.value.title ?? ""),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNode(
      bool isCompleted, bool isSelected, Color primary, ThemeData theme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted
            ? primary
            : (isSelected
                ? theme.cardColor
                : theme.dividerColor.withOpacity(0.1)),
        border: Border.all(
          color: isSelected ? primary : Colors.transparent,
          width: 2,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                    color: primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4))
              ]
            : [],
      ),
      child: Center(
        child: isCompleted
            ? const Icon(Icons.check, color: Colors.white, size: 20)
            : Text(
                "${currentStep + 1}",
                style: TextStyle(
                    color: isSelected ? primary : Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  Widget _buildDynamicTrack(BuildContext context, int count, Color primary) {
    return Positioned(
      top: 20,
      child: Container(
        height: 2,
        width: (count - 1) * 120.0,
        color: Colors.grey.withOpacity(0.1),
      ),
    );
  }
}
