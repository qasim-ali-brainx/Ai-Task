import 'package:equatable/equatable.dart';

abstract class BriefEvent extends Equatable {
  const BriefEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class BriefFileSelected extends BriefEvent {
  const BriefFileSelected(this.filePath);
  final String filePath;

  @override
  List<Object?> get props => <Object?>[filePath];
}

class AnalyzeBriefRequested extends BriefEvent {
  const AnalyzeBriefRequested({required this.briefText});
  final String briefText;

  @override
  List<Object?> get props => <Object?>[briefText];
}

class ClarificationsSubmitted extends BriefEvent {
  const ClarificationsSubmitted(this.answers);
  final Map<String, String> answers;

  @override
  List<Object?> get props => <Object?>[answers];
}
