import '../../domain/models/ticket_entity.dart';

class TicketModel extends TicketEntity {
  const TicketModel({
    required super.id,
    required super.title,
    required super.description,
    required super.acceptanceCriteria,
    required super.priority,
    required super.complexityPoints,
    required super.technicalNotes,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      acceptanceCriteria:
          (json['acceptanceCriteria'] as List<dynamic>? ?? <dynamic>[])
              .map((dynamic item) => item.toString())
              .toList(),
      priority: json['priority'] as String? ?? 'Low',
      complexityPoints: (json['complexityPoints'] as num?)?.toInt() ?? 1,
      technicalNotes: json['technicalNotes'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'acceptanceCriteria': acceptanceCriteria,
      'priority': priority,
      'complexityPoints': complexityPoints,
      'technicalNotes': technicalNotes,
    };
  }
}
