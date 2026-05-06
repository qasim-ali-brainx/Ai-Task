import 'package:equatable/equatable.dart';

import '../../../domain/models/ticket_entity.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class TicketLoaded extends TicketEvent {
  const TicketLoaded(this.tickets);
  final List<TicketEntity> tickets;

  @override
  List<Object?> get props => <Object?>[tickets];
}

class TicketFilterChanged extends TicketEvent {
  const TicketFilterChanged(this.filter);
  final String filter;

  @override
  List<Object?> get props => <Object?>[filter];
}
