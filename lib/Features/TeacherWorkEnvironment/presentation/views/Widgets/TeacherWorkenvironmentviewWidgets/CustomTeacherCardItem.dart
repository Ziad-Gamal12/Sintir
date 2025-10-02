import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:svg_flutter/svg.dart';

class CustomTeacherCardItem extends StatelessWidget {
  const CustomTeacherCardItem({super.key, required this.user});
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return CreditCardWidget(
      cardNumber: user.teacherExtraDataEntity?.wallet.walletId.toString() ?? "",
      expiryDate: "${user.teacherExtraDataEntity?.wallet.createdAt}",
      cardHolderName: "${user.firstName} ${user.lastName}",
      cvvCode: "${user.teacherExtraDataEntity?.wallet.balance}EGP",
      showBackView: false,
      onCreditCardWidgetChange: (CreditCardBrand brand) {},
      bankName: "Sintir Wallet",
      enableFloatingCard: true,
      obscureCardNumber: false,
      obscureInitialCardNumber: false,
      obscureCardCvv: false,
      labelCardHolder: "${user.firstName} ${user.lastName}",
      cardType: CardType.otherBrand,
      isHolderNameVisible: true,
      height: 175,
      textStyle: AppTextStyles(context).semiBold14.copyWith(
            color: Colors.white,
          ),
      width: MediaQuery.of(context).size.width,
      isChipVisible: true,
      isSwipeGestureEnabled: true,
      animationDuration: const Duration(milliseconds: 1000),
      padding: 16,
      glassmorphismConfig: Glassmorphism(
        blurX: 10,
        blurY: 10,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF000000),
            Color(0xFF1C1C1C),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      labelValidThru: "At :",
      customCardTypeIcons: [
        CustomCardTypeIcon(
          cardType: CardType.otherBrand,
          cardImage: SvgPicture.asset(Assets.assetsImagesSVGImagesSintirLogo,
              height: 50, width: 50),
        ),
      ],
    );
  }
}
