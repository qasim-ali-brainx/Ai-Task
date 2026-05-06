import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_strings.dart';
import '../../../domain/models/ticket_entity.dart';
import '../../widgets/common/app_chip.dart';

class TicketDetailScreen extends StatelessWidget {
  const TicketDetailScreen({required this.ticket, super.key});
  final TicketEntity ticket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Clipboard.setData(
                ClipboardData(
                  text:
                      '${ticket.title}\n${ticket.description}\n${ticket.acceptanceCriteria.join('\n')}',
                ),
              );
            },
            icon: const Icon(Icons.copy),
            tooltip: AppStrings.copyTicket,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
            tooltip: AppStrings.shareTicket,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(ticket.title, style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              AppChip(label: ticket.priority),
              const SizedBox(width: 8),
              Text('${ticket.complexityPoints} SP'),
            ],
          ),
          const SizedBox(height: 16),
          const Text(AppStrings.description),
          Text(ticket.description),
          const SizedBox(height: 16),
          const Text(AppStrings.acceptanceCriteria),
          ...ticket.acceptanceCriteria.map((String e) => Text('• $e')),
          const SizedBox(height: 16),
          const Text(AppStrings.technicalNotes),
          Text(ticket.technicalNotes),
        ],
      ),
    );
  }
}
