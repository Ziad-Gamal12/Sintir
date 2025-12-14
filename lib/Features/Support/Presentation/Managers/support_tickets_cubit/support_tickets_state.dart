part of 'support_tickets_cubit.dart';

@immutable
sealed class SupportTicketsState {}

final class SupportTicketsInitial extends SupportTicketsState {}

// send Ticket
final class SendSupportTicketLoading extends SupportTicketsState {}

final class SendSupportTicketSuccess extends SupportTicketsState {}

final class SendSupportTicketFailure extends SupportTicketsState {
  final String errMessage;
  SendSupportTicketFailure({required this.errMessage});
}

// Delete Ticket
final class DeleteSupportTicketLoading extends SupportTicketsState {}

final class DeleteSupportTicketSuccess extends SupportTicketsState {}

final class DeleteSupportTicketFailure extends SupportTicketsState {
  final String errMessage;
  DeleteSupportTicketFailure({required this.errMessage});
}

// Get User Support Tickets
final class GetUserSupportTicketsLoading extends SupportTicketsState {
  final bool isPaginate;
  GetUserSupportTicketsLoading({required this.isPaginate});
}

final class GetUserSupportTicketsSuccess extends SupportTicketsState {
  final GetSupportTicketsResponseEntity response;
  GetUserSupportTicketsSuccess({required this.response});
}

final class GetUserSupportTicketsFailure extends SupportTicketsState {
  final String errMessage;
  GetUserSupportTicketsFailure({required this.errMessage});
}
