import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/Support/Domain/Entities/GetSupportTicketsResponseEntity.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/Features/Support/Domain/Repos/SupportTicketsRepo.dart';

part 'support_tickets_state.dart';

class SupportTicketsCubit extends Cubit<SupportTicketsState> {
  SupportTicketsCubit({required this.supportTicketsRepo})
      : super(SupportTicketsInitial());
  final SupportTicketsRepo supportTicketsRepo;
  // Send Support Ticket
  Future<void> sendSupportTicket(
      {required SupportTicketEntity supportTicket}) async {
    emit(SendSupportTicketLoading());
    final response = await supportTicketsRepo.sendSupportTicket(
        supportTicket: supportTicket);
    response.fold(
        (failure) => emit(SendSupportTicketFailure(
              errMessage: failure.message,
            )),
        (response) => emit(SendSupportTicketSuccess()));
  }

// Delete Support Ticket
  Future<void> deleteSupportTicket({required String ticketId}) async {
    emit(DeleteSupportTicketLoading());
    final response =
        await supportTicketsRepo.deleteSupportTicket(ticketId: ticketId);
    response.fold(
        (failure) => emit(DeleteSupportTicketFailure(
              errMessage: failure.message,
            )),
        (response) => emit(DeleteSupportTicketSuccess()));
  }

// get User Support Tickets
  Future<void> getUserSupportTickets(
      {required String userId, required bool isPaginate}) async {
    emit(GetUserSupportTicketsLoading(isPaginate: isPaginate));
    final response = await supportTicketsRepo.getUserSupportTickets(
        userId: userId, isPaginate: isPaginate);
    response.fold(
        (failure) => emit(GetUserSupportTicketsFailure(
              errMessage: failure.message,
            )),
        (response) => emit(GetUserSupportTicketsSuccess(response: response)));
  }
}
