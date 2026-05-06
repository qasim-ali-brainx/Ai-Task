import 'package:ai_project_management_tool/domain/models/ticket_entity.dart';
import 'package:ai_project_management_tool/presentation/bloc/ticket/ticket_bloc.dart';
import 'package:ai_project_management_tool/presentation/bloc/ticket/ticket_event.dart';
import 'package:ai_project_management_tool/presentation/bloc/ticket/ticket_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const TicketEntity highTicket = TicketEntity(
    id: '1',
    title: 'Auth',
    description: 'Build auth',
    acceptanceCriteria: <String>['a'],
    priority: 'High',
    complexityPoints: 3,
    technicalNotes: '',
  );
  const TicketEntity lowTicket = TicketEntity(
    id: '2',
    title: 'Docs',
    description: 'Write docs',
    acceptanceCriteria: <String>['b'],
    priority: 'Low',
    complexityPoints: 1,
    technicalNotes: '',
  );

  group('TicketBloc', () {
    blocTest<TicketBloc, TicketState>(
      'loads and filters tickets',
      build: TicketBloc.new,
      act: (TicketBloc bloc) {
        bloc
          ..add(const TicketLoaded(<TicketEntity>[highTicket, lowTicket]))
          ..add(const TicketFilterChanged('High'));
      },
      expect: () => <TicketState>[
        const TicketReady(
          allTickets: <TicketEntity>[highTicket, lowTicket],
          filteredTickets: <TicketEntity>[highTicket, lowTicket],
          filter: 'All',
        ),
        const TicketReady(
          allTickets: <TicketEntity>[highTicket, lowTicket],
          filteredTickets: <TicketEntity>[highTicket],
          filter: 'High',
        ),
      ],
    );
  });
}
