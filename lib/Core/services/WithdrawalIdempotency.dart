import 'dart:convert';

class WithdrawalRequestSnapshot {
  const WithdrawalRequestSnapshot({
    required this.idempotencyKey,
    required this.amount,
    required this.issuer,
    required this.mobileNumber,
  });

  final String idempotencyKey;
  final double amount;
  final String issuer;
  final String mobileNumber;

  String encode() => jsonEncode({
        'idempotencyKey': idempotencyKey,
        'amount': amount,
        'issuer': issuer,
        'mobileNumber': mobileNumber,
      });

  static WithdrawalRequestSnapshot decode(String value) {
    final data = jsonDecode(value);
    if (data is! Map<String, dynamic> ||
        data['idempotencyKey'] is! String ||
        data['amount'] is! num ||
        data['issuer'] is! String ||
        data['mobileNumber'] is! String) {
      throw const FormatException('Invalid pending withdrawal request.');
    }
    return WithdrawalRequestSnapshot(
      idempotencyKey: data['idempotencyKey'] as String,
      amount: (data['amount'] as num).toDouble(),
      issuer: data['issuer'] as String,
      mobileNumber: data['mobileNumber'] as String,
    );
  }

  bool matches({
    required double amount,
    required String issuer,
    required String mobileNumber,
  }) =>
      this.amount == amount &&
      this.issuer == issuer &&
      this.mobileNumber == mobileNumber;

  static WithdrawalRequestSnapshot resolve({
    required String? saved,
    required String proposedKey,
    required double amount,
    required String issuer,
    required String mobileNumber,
  }) {
    WithdrawalRequestSnapshot? pending;
    if (saved != null) {
      try {
        pending = decode(saved);
      } on FormatException {
        // Migrate key-only preferences written by the previous app version.
        if (!RegExp(r'^[a-f0-9-]{36}$', caseSensitive: false).hasMatch(saved)) {
          rethrow;
        }
        pending = WithdrawalRequestSnapshot(
          idempotencyKey: saved,
          amount: amount,
          issuer: issuer,
          mobileNumber: mobileNumber,
        );
      }
    }
    if (pending != null &&
        !pending.matches(
          amount: amount,
          issuer: issuer,
          mobileNumber: mobileNumber,
        )) {
      throw StateError(
        'A previous withdrawal is unresolved. Retry it with the original amount and payout details.',
      );
    }
    return pending ?? WithdrawalRequestSnapshot(
      idempotencyKey: proposedKey,
      amount: amount,
      issuer: issuer,
      mobileNumber: mobileNumber,
    );
  }
}

bool withdrawalRequestIsResolved(String status) =>
    const {'SUCCESS', 'FAILED'}.contains(status.toUpperCase());
