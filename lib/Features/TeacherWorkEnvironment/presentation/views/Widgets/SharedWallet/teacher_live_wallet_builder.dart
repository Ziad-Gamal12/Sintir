import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/states/teacher_wallet_error_card.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/states/teacher_wallet_skeleton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/states/teacher_wallet_stale_notice.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_wallet_cubit/teacher_wallet_cubit.dart';

typedef TeacherLiveWalletWidgetBuilder =
    Widget Function(
      BuildContext context,
      TeacherWalletEntity wallet,
      Widget? staleNotice,
    );

class TeacherLiveWalletBuilder extends StatelessWidget {
  const TeacherLiveWalletBuilder({
    super.key,
    required this.builder,
    this.loading = const TeacherWalletSkeleton(),
  });

  final TeacherLiveWalletWidgetBuilder builder;
  final Widget loading;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherWalletCubit, TeacherWalletState>(
      builder: (context, state) {
        final retry = context.read<TeacherWalletCubit>().watchWallet;

        final child = switch (state) {
          TeacherWalletLoading() => loading,
          TeacherWalletLoaded(:final wallet) => builder(context, wallet, null),
          TeacherWalletFailure(wallet: final wallet?) => builder(
            context,
            wallet,
            TeacherWalletStaleNotice(onRetry: retry),
          ),
          TeacherWalletFailure(:final message) => TeacherWalletErrorCard(
            message: message,
            onRetry: retry,
          ),
        };

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          layoutBuilder: (current, previous) => Stack(
            alignment: AlignmentDirectional.topStart,
            children: [...previous, ?current],
          ),
          child: RepaintBoundary(
            key: ValueKey(state.runtimeType),
            child: child,
          ),
        );
      },
    );
  }
}
