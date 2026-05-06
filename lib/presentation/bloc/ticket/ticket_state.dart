import 'package:equatable/equatable.dart';

import '../../../domain/models/ticket_entity.dart';

abstract class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object?> get props => <Object?>[];
}

class TicketInitial extends TicketState {
  const TicketInitial();
}

class TicketReady extends TicketState {
  const TicketReady({
    required this.allTickets,
    required this.filteredTickets,
    required this.filter,
  });

  final List<TicketEntity> allTickets;
  final List<TicketEntity> filteredTickets;
  final String filter;

  @override
  List<Object?> get props => <Object?>[allTickets, filteredTickets, filter];
}

class TicketError extends TicketState {
  const TicketError(this.message);
  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
