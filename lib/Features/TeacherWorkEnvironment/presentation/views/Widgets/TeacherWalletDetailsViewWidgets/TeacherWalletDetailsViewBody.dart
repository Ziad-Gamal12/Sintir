import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/Auth/Data/models/UserModel.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletDetailsViewBodyBuilder.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWalletDetailsViewBody extends StatefulWidget {
  const TeacherWalletDetailsViewBody({
    super.key,
  });
  @override
  State<TeacherWalletDetailsViewBody> createState() =>
      _TeacherWalletDetailsViewBodyState();
}

class _TeacherWalletDetailsViewBodyState
    extends State<TeacherWalletDetailsViewBody> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> walletStream;
  String teacherId = getUserData().uid;
  @override
  void initState() {
    super.initState();
    walletStream = FirebaseFirestore.instance
        .collection(BackendEndpoints.usersCollectionName)
        .doc(teacherId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: walletStream,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return Center(
              child: CustomErrorWidget(
                  errormessage: LocaleKeys.errorOccurredMessage),
            );
          }
          if (!asyncSnapshot.hasData || !asyncSnapshot.data!.exists) {
            return Center(
              child: CustomErrorWidget(
                  errormessage: LocaleKeys.walletNotFoundError),
            );
          }
          final data = asyncSnapshot.data!.data();
          if (data == null) {
            return Center(
              child: CustomErrorWidget(
                  errormessage: LocaleKeys.walletDocumentEmptyError),
            );
          }
          UserEntity user = UserModel.fromJson(data).toEntity();
          final wallet = user.teacherExtraDataEntity?.wallet;
          if (wallet == null) {
            return Center(
              child: CustomErrorWidget(
                  errormessage: LocaleKeys.walletNotFoundError),
            );
          }
          return TeacherWalletDetailsViewBodyBuilder(
              wallet: wallet,
              user: user,
              colorScheme: colorScheme,
              teacherId: teacherId);
        });
  }
}
