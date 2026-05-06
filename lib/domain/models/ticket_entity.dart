import 'package:equatable/equatable.dart';

class TicketEntity extends Equatable {
  const TicketEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.acceptanceCriteria,
    required this.priority,
    required this.complexityPoints,
    required this.technicalNotes,
  });

  final String id;
  final String title;
  final String description;
  final List<String> acceptanceCriteria;
  final String priority;
  final int complexityPoints;
  final String technicalNotes;

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        description,
        acceptanceCriteria,
        priority,
        complexityPoints,
        technicalNotes,
      ];
}
