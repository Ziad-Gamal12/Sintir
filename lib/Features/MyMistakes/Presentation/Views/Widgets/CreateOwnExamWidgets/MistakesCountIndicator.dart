import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Manager/create_my_exam_bloc/create_my_exam_bloc.dart';

// mistakes_count_indicator.dart
class MistakesCountIndicator extends StatelessWidget {
  final String subjectId;
  final Color color;

  const MistakesCountIndicator(
      {super.key, required this.subjectId, required this.color});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMyExamBloc, CreateMyExamState>(
      buildWhen: (p, c) =>
          p.loadingStates[subjectId] != c.loadingStates[subjectId] ||
          p.mistakesCounts[subjectId] != c.mistakesCounts[subjectId],
      builder: (context, state) {
        final isLoading = state.loadingStates[subjectId] ?? false;
        final count = state.mistakesCounts[subjectId];
        final hasError = state.errorMessages[subjectId] != null;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isLoading
              ? _buildLoader()
              : hasError
                  ? Icon(Icons.error_outline, size: 14, color: color)
                  : _buildBadge(context, count ?? 0),
        );
      },
    );
  }

  Widget _buildBadge(BuildContext context, int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text("$count",
          style: TextStyle(
              color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildLoader() => SizedBox(
      width: 12,
      height: 12,
      child: CircularProgressIndicator(
          strokeWidth: 1.5,
          valueColor: AlwaysStoppedAnimation(color.withOpacity(0.5))));
}
