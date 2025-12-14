// support_card_helpers.dart (No functional change, just showing context)

import 'package:flutter/material.dart';

Color getSupportCardStatusColor(BuildContext context, String status) {
  final lowerStatus = status.toLowerCase();
  if (lowerStatus == 'closed' || lowerStatus == 'resolved') {
    return Colors.green.shade600;
  } else if (lowerStatus == 'pending' || lowerStatus == 'open') {
    return Colors.amber.shade600;
  } else if (lowerStatus == 'waiting' || lowerStatus == 'urgent') {
    return Colors.red.shade400;
  }
  return Theme.of(context).colorScheme.secondary;
}
