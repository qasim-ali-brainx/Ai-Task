import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../domain/models/ticket_entity.dart';
import '../../bloc/ticket/ticket_bloc.dart';
import '../../bloc/ticket/ticket_event.dart';
import '../../bloc/ticket/ticket_state.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/ticket_card.dart';

class TicketListScreen extends StatelessWidget {
  const TicketListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<TicketBloc, TicketState>(
          buildWhen: (TicketState previous, TicketState current) => current is TicketReady,
          builder: (_, TicketState state) {
            final int count = state is TicketReady ? state.filteredTickets.length : 0;
            return Text('${AppStrings.generatedTickets} ($count)');
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final TicketState state = context.read<TicketBloc>().state;
              if (state is TicketReady) {
                Clipboard.setData(
                  ClipboardData(
                    text: jsonEncode(
                      state.filteredTickets
                          .map((TicketEntity e) => <String, dynamic>{
                                'title': e.title,
                                'description': e.description,
                                'acceptanceCriteria': e.acceptanceCriteria,
                                'priority': e.priority,
                                'complexityPoints': e.complexityPoints,
                              })
                          .toList(),
                    ),
                  ),
                );
              }
            },
            icon: const Icon(Icons.copy_all),
            tooltip: AppStrings.copyAll,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const _FilterRow(),
          Expanded(
            child: BlocBuilder<TicketBloc, TicketState>(
              buildWhen: (TicketState previous, TicketState current) =>
                  current is TicketReady || current is TicketError,
              builder: (BuildContext context, TicketState state) {
                if (state is TicketError) {
                  return AppErrorWidget(
                    message: state.message,
                    onRetry: () {},
                  );
                }
                if (state is! TicketReady || state.filteredTickets.isEmpty) {
                  return const Center(child: Text(AppStrings.noTicketsGenerated));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.filteredTickets.length,
                  itemBuilder: (BuildContext context, int index) {
                    final TicketEntity ticket = state.filteredTickets[index];
                    return TicketCard(
                      ticket: ticket,
                      onTap: () => context.push(AppRoutes.ticketDetail, extra: ticket),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow();

  @override
  Widget build(BuildContext context) {
    const List<String> filters = <String>['All', 'High', 'Medium', 'Low'];
    return BlocBuilder<TicketBloc, TicketState>(
      buildWhen: (TicketState previous, TicketState current) => current is TicketReady,
      builder: (BuildContext context, TicketState state) {
        final String selected = state is TicketReady ? state.filter : 'All';
        return Wrap(
          spacing: 8,
          children: filters
              .map(
                (String filter) => ChoiceChip(
                  label: Text(filter),
                  selected: selected == filter,
                  onSelected: (_) =>
                      context.read<TicketBloc>().add(TicketFilterChanged(filter)),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
