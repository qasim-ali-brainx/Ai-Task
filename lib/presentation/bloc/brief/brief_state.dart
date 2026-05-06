import 'package:equatable/equatable.dart';

import '../../../domain/models/ticket_entity.dart';

abstract class BriefState extends Equatable {
  const BriefState();

  @override
  List<Object?> get props => <Object?>[];
}

class BriefInitial extends BriefState {
  const BriefInitial();
}

class BriefFilePicked extends BriefState {
  const BriefFilePicked({
    required this.filePath,
    required this.fullText,
    required this.previewText,
    required this.fileName,
    required this.fileSizeBytes,
  });

  final String filePath;
  final String fullText;
  final String previewText;
  final String fileName;
  final int fileSizeBytes;

  @override
  List<Object?> get props => <Object?>[
        filePath,
        fullText,
        previewText,
        fileName,
        fileSizeBytes,
      ];
}

class BriefExtracting extends BriefState {
  const BriefExtracting();
}

class BriefAnalyzing extends BriefState {
  const BriefAnalyzing();
}

class BriefNeedsClarification extends BriefState {
  const BriefNeedsClarification(this.questions, {required this.originalBriefText});
  final List<String> questions;
  final String originalBriefText;

  @override
  List<Object?> get props => <Object?>[questions, originalBriefText];
}

class BriefComplete extends BriefState {
  const BriefComplete(this.tickets);
  final List<TicketEntity> tickets;

  @override
  List<Object?> get props => <Object?>[tickets];
}

class BriefError extends BriefState {
  const BriefError(this.message);
  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
