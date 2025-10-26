import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/addingJoinedByLoadingWidget.dart';

class TestLoadingOverlay extends StatelessWidget {
  const TestLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((TestItemCubit cubit) => cubit.state is JoinToTestItemLoading);

    return Visibility(
      visible: isLoading,
      child: const Positioned(
        bottom: 16,
        left: 16,
        right: 16,
        child: addingJoinedByLoadingWidget(),
      ),
    );
  }
}
