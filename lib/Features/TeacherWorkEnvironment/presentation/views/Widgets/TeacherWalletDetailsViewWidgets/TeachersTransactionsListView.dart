import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/models/TransactionModel.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeachersTransactionsListViewItem.dart';
import 'package:sintir/locale_keys.dart';

// 1. Define Constant for Padding
const _kItemPadding = EdgeInsets.symmetric(vertical: 20);

class TeachersTransactionsListView extends StatefulWidget {
  // teacherId is required, good.
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
        .doc(widget.teacherId) // Using the passed teacherId
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
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return SliverToBoxAdapter(
              child: CustomErrorWidget(
                  errormessage: LocaleKeys.errorOccurredMessage));
        }

        // Handle data state
        if (snapshot.hasData) {
          final documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return SliverToBoxAdapter(
              child: CustomEmptyWidget(),
            );
          }

          List<TransactionEntity> transactions = documents
              .map((doc) {
                final data = doc.data() as Map<String, dynamic>?;
                if (data == null) {
                  return null;
                }
                try {
                  return TransactionModel.fromJson(data).toEntity();
                } catch (e) {
                  log("Conversion Error for doc ${doc.id}: $e");
                  return null;
                }
              })
              .whereType<TransactionEntity>()
              .toList();

          return SliverList.builder(
            itemCount: transactions.length,
            // 4. Using the extracted constant for padding
            itemBuilder: (context, index) {
              return Padding(
                padding: _kItemPadding,
                child: TeachersTransactionsListViewItem(
                  transaction: transactions[index],
                  teacherId: widget.teacherId,
                ),
              );
            },
          );
        }

        return SliverToBoxAdapter(
            child: CustomErrorWidget(
                errormessage: LocaleKeys.errorOccurredMessage));
      },
    );
  }
}
