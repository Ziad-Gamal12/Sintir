import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/Features/Support/Presentation/Managers/support_tickets_cubit/support_tickets_cubit.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/MySupportTicketsViewWidgets/MySupportTicketsViewBodyLoadingListView.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/MySupportTicketsViewWidgets/MySupportTicketsViewBodyMySupportTicketsSliverListView.dart';
import 'package:sintir/locale_keys.dart';

class MySupportTicketsViewBody extends StatefulWidget {
  const MySupportTicketsViewBody({super.key});

  @override
  State<MySupportTicketsViewBody> createState() =>
      _MySupportTicketsViewBodyState();
}

class _MySupportTicketsViewBodyState extends State<MySupportTicketsViewBody> {
  late ScrollController _scrollController;
  bool hasMore = true;
  List<SupportTicketEntity> fetchedSupportTickets = [];
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    String userUID = getUserData().uid;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<SupportTicketsCubit>()
          .getUserSupportTickets(userId: userUID, isPaginate: false);
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent - 200 &&
            hasMore &&
            context.read<SupportTicketsCubit>().state
                is! GetUserSupportTicketsLoading) {
          if (hasMore) {
            context
                .read<SupportTicketsCubit>()
                .getUserSupportTickets(userId: userUID, isPaginate: true);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupportTicketsCubit, SupportTicketsState>(
      listener: (context, state) {
        if (state is GetUserSupportTicketsSuccess) {
          if (state.response.isPaginate == true) {
            fetchedSupportTickets.addAll(state.response.supportTickets);
          } else {
            fetchedSupportTickets = state.response.supportTickets;
          }
          hasMore = state.response.hasMore;
        }
      },
      builder: (context, state) {
        if (state is GetUserSupportTicketsFailure) {
          return Center(
            child: CustomErrorWidget(errormessage: state.errMessage),
          );
        } else if (state is GetUserSupportTicketsLoading &&
            state.isPaginate == false) {
          return const MySupportTicketsViewBodyLoadingListView();
        } else if (state is GetUserSupportTicketsSuccess &&
            fetchedSupportTickets.isEmpty) {
          return CustomEmptyWidget(
            text: LocaleKeys.emptyContent,
          );
        } else {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              MySupportTicketsViewBodyMySupportTicketsSliverListView(
                  supportTickets: fetchedSupportTickets),
              SliverToBoxAdapter(
                child: state is GetUserSupportTicketsLoading && hasMore
                    ? const MySupportTicketsViewBodyLoadingListView()
                    : null,
              )
            ],
          );
        }
      },
    );
  }
}
