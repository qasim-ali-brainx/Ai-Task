import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_constants.dart';
import '../../../data/models/api_result.dart';
import '../../../domain/usecases/analyze_brief_usecase.dart';
import '../../../domain/usecases/extract_pdf_usecase.dart';
import 'brief_event.dart';
import 'brief_state.dart';

class BriefBloc extends Bloc<BriefEvent, BriefState> {
  BriefBloc({
    required AnalyzeBriefUseCase analyzeBriefUseCase,
    required ExtractPdfUseCase extractPdfUseCase,
  })  : _analyzeBriefUseCase = analyzeBriefUseCase,
        _extractPdfUseCase = extractPdfUseCase,
        super(const BriefInitial()) {
    on<BriefFileSelected>(_onFileSelected);
    on<AnalyzeBriefRequested>(_onAnalyzeRequested);
    on<ClarificationsSubmitted>(_onClarificationsSubmitted);
  }

  final AnalyzeBriefUseCase _analyzeBriefUseCase;
  final ExtractPdfUseCase _extractPdfUseCase;

  String _briefText = '';

  Future<void> _onFileSelected(
    BriefFileSelected event,
    Emitter<BriefState> emit,
  ) async {
    emit(const BriefExtracting());
    final File file = File(event.filePath);
    final int fileSize = await file.length();

    final ApiResult<String> extractResult = await _extractPdfUseCase(event.filePath);
    if (extractResult is ApiFailure<String>) {
      emit(BriefError(extractResult.message));
      return;
    }

    _briefText = (extractResult as ApiSuccess<String>).data;
    if (_briefText.length > AppConstants.maxExtractedCharacters) {
      _briefText = _briefText.substring(0, AppConstants.maxExtractedCharacters);
    }
    emit(
      BriefFilePicked(
        filePath: event.filePath,
        fullText: _briefText,
        previewText: _briefText.substring(
          0,
          _briefText.length > AppConstants.pdfPreviewCharacterCount
              ? AppConstants.pdfPreviewCharacterCount
              : _briefText.length,
        ),
        fileName: file.uri.pathSegments.last,
        fileSizeBytes: fileSize,
      ),
    );
  }

  Future<void> _onAnalyzeRequested(
    AnalyzeBriefRequested event,
    Emitter<BriefState> emit,
  ) async {
    emit(const BriefAnalyzing());
    final ApiResult<dynamic> result = await _analyzeBriefUseCase(event.briefText);
    if (result is ApiFailure<dynamic>) {
      emit(BriefError(result.message));
      return;
    }
    final data = (result as ApiSuccess<dynamic>).data;
    if (data.needsClarification == true) {
      emit(
        BriefNeedsClarification(
          data.clarifications as List<String>,
          originalBriefText: event.briefText,
        ),
      );
      return;
    }
    emit(BriefComplete(data.tickets));
  }

  Future<void> _onClarificationsSubmitted(
    ClarificationsSubmitted event,
    Emitter<BriefState> emit,
  ) async {
    final StringBuffer enriched = StringBuffer(_briefText);
    enriched.writeln('\nClarifications:');
    event.answers.forEach((String question, String answer) {
      enriched.writeln('$question: $answer');
    });
    add(AnalyzeBriefRequested(briefText: enriched.toString()));
  }
}
