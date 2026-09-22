class WithdrawalMethodEntity {
  const WithdrawalMethodEntity(
      {required this.id,
      required this.nameKey,
      required this.subtitleKey,
      required this.svgAssetPath,
      this.isInstant = true});
  final String id;
  final String nameKey;
  final String subtitleKey;
  final String svgAssetPath;
  final bool isInstant;
}
