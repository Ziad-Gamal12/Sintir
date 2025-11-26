import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class PayoutTermsAndConditionsViewBody extends StatelessWidget {
  const PayoutTermsAndConditionsViewBody({super.key});

  Widget _buildSection(String title, String body, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.right,
            style: AppTextStyles(context).semiBold16,
          ),
          const SizedBox(height: 8),
          Text(
            body,
            textAlign: TextAlign.right,
            style: AppTextStyles(context).regular14,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Arabic Terms & Conditions text organized into clear sections
    final introTitle = LocaleKeys.payoutIntroTitle;
    final introBody = LocaleKeys.payoutIntroBody;

    final methodTitle = LocaleKeys.payoutMethodTitle;
    final methodBody = LocaleKeys.payoutMethodBody;
    final eligibilityTitle = LocaleKeys.payoutEligibilityTitle;
    final eligibilityBody = LocaleKeys.payoutEligibilityBody;
    final minimumTitle = LocaleKeys.payoutMinimumTitle;
    final minimumBody = LocaleKeys.payoutMinimumBody;

    final processingTitle = LocaleKeys.payoutProcessingTitle;
    final processingBody = LocaleKeys.payoutProcessingBody;
    final feesTitle = LocaleKeys.payoutFeesTitle;
    final feesBody = LocaleKeys.payoutFeesBody;
    final updateInfoTitle = LocaleKeys.payoutUpdateInfoTitle;
    final updateInfoBody = LocaleKeys.payoutUpdateInfoBody;

    final refundsTitle = LocaleKeys.payoutRefundsTitle;
    final refundsBody = LocaleKeys.payoutRefundsBody;

    final fraudTitle = LocaleKeys.payoutFraudTitle;
    final fraudBody = LocaleKeys.payoutFraudBody;
    final supportTitle = LocaleKeys.payoutSupportTitle;
    final supportBody = LocaleKeys.payoutSupportBody;
    final acceptanceTitle = LocaleKeys.payoutAcceptanceTitle;
    final acceptanceBody = LocaleKeys.payoutAcceptanceBody;

    return Scrollbar(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 6),
            _buildSection(introTitle, introBody, context),
            _buildSection(methodTitle, methodBody, context),
            _buildSection(eligibilityTitle, eligibilityBody, context),
            _buildSection(minimumTitle, minimumBody, context),
            _buildSection(processingTitle, processingBody, context),
            _buildSection(feesTitle, feesBody, context),
            _buildSection(updateInfoTitle, updateInfoBody, context),
            _buildSection(refundsTitle, refundsBody, context),
            _buildSection(fraudTitle, fraudBody, context),
            _buildSection(supportTitle, supportBody, context),
            _buildSection(acceptanceTitle, acceptanceBody, context),
          ],
        ),
      ),
    );
  }
}
