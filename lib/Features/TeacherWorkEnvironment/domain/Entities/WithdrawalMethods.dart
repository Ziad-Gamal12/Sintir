import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/WithdrawalMethodEntity.dart';

class WithdrawalMethods {
  static const all = <WithdrawalMethodEntity>[
    WithdrawalMethodEntity(
        id: 'vodafone',
        nameKey: 'issuer_vodafone_cash',
        subtitleKey: 'withdrawal_instant',
        svgAssetPath: Assets.assetsIconsSVGIconsVodafoneLogo),
    WithdrawalMethodEntity(
        id: 'orange',
        nameKey: 'issuer_orange_cash',
        subtitleKey: 'withdrawal_direct_transfer',
        svgAssetPath: Assets.assetsIconsSVGIconsOrangeLogo),
    WithdrawalMethodEntity(
        id: 'etisalat',
        nameKey: 'issuer_etisalat_cash',
        subtitleKey: 'withdrawal_direct_transfer',
        svgAssetPath: Assets.assetsIconsSVGIconsEtisalatLogo),
  ];
}
