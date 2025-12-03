import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/data/Models/TransactionModel.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TransactionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeachersTransactionsListViewItem.dart';

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
    String teacherId = getUserData().uid;
    transactionsStream = FirebaseFirestore.instance
        .collection(BackendEndpoints.usersCollectionName)
        .doc(teacherId)
        .collection(BackendEndpoints.transactionsSubCollection)
        .orderBy("created_at", descending: true)
        .limit(10)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: transactionsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data!.docs;
          List<Map<String, dynamic>> data = documents
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
          List<TransactionEntity> transactions = data
              .map((doc) => TransactionModel.fromJson(doc).toEntity())
              .toList();
          return SliverList.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TeachersTransactionsListViewItem(
                  transaction: transactions[index],
                  teacherId: widget.teacherId,
                ),
              );
            },
          );
        } else {
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
