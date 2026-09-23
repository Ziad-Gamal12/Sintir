import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/models/TransactionModel.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherWalletTransactionItemRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletTransactions/TeachersTransactionsListViewItem.dart';
import 'package:sintir/locale_keys.dart';

const _kItemPadding = EdgeInsets.symmetric(vertical: 20);

class TeachersTransactionsListView extends StatefulWidget {
  const TeachersTransactionsListView({super.key, required this.teacherId});
  final String teacherId;
  @override
  State<TeachersTransactionsListView> createState() =>
      _TeachersTransactionsListViewState();
}

class _TeachersTransactionsListViewState
    extends State<TeachersTransactionsListView> {
  late Stream<QuerySnapshot> transactionsStream;

  @override
  void initState() {
    super.initState();
    transactionsStream = FirebaseFirestore.instance
        .collection(BackendEndpoints.usersCollectionName)
        .doc(widget.teacherId)
        .collection(BackendEndpoints.transactionsSubCollection)
        .orderBy("created_at", descending: true)
        .where("method", isEqualTo: BackendEndpoints.payOutMethod)
        .limit(10)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: transactionsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: CustomErrorWidget(
                errormessage: LocaleKeys.errorOccurredMessage),
          );
        }

        if (snapshot.hasData) {
          final documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: CustomEmptyWidget(),
            );
          }

          List<TransactionEntity> transactions = documents
              .map((doc) {
                final data = doc.data() as Map<String, dynamic>?;
                if (data == null) return null;
                try {
                  return TransactionModel.fromJson(data).toEntity();
                } catch (e) {
                  return null;
                }
              })
              .whereType<TransactionEntity>()
              .toList();
          return SliverList.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Padding(
                key: ValueKey(transactions[index].transactionId),
                padding: _kItemPadding,
                child: TeachersTransactionsListViewItem(
                  transactionRequirements:
                      TeacherWalletTransactionItemRequirements(
                          transaction: transactions[index],
                          teacherId: widget.teacherId),
                ),
              );
            },
          );
        }

        return SliverFillRemaining(
          hasScrollBody: false,
          child:
              CustomErrorWidget(errormessage: LocaleKeys.errorOccurredMessage),
        );
      },
    );
  }
}
