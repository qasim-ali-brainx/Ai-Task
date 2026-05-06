import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/ticket_entity.dart';
import 'ticket_event.dart';
import 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(const TicketInitial()) {
    on<TicketLoaded>(_onLoaded);
    on<TicketFilterChanged>(_onFilterChanged);
  }

  List<TicketEntity> _allTickets = <TicketEntity>[];

  void _onLoaded(TicketLoaded event, Emitter<TicketState> emit) {
    _allTickets = event.tickets;
    emit(
      TicketReady(
        allTickets: _allTickets,
        filteredTickets: _allTickets,
        filter: _allFilter,
      ),
    );
  }

  void _onFilterChanged(TicketFilterChanged event, Emitter<TicketState> emit) {
    final List<TicketEntity> filtered;
    if (event.filter == _allFilter) {
      filtered = _allTickets;
    } else {
      filtered = _allTickets
          .where((TicketEntity ticket) => ticket.priority == event.filter)
          .toList();
    }
    emit(
      TicketReady(
        allTickets: _allTickets,
        filteredTickets: filtered,
        filter: event.filter,
      ),
    );
  }

  static const String _allFilter = 'All';
}
