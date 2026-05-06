import 'package:ai_project_management_tool/data/managers/dio/data_source.dart';
import 'package:ai_project_management_tool/data/models/api_result.dart';
import 'package:ai_project_management_tool/domain/usecases/analyze_brief_usecase.dart';
import 'package:ai_project_management_tool/domain/usecases/extract_pdf_usecase.dart';
import 'package:ai_project_management_tool/presentation/bloc/brief/brief_bloc.dart';
import 'package:ai_project_management_tool/presentation/bloc/brief/brief_event.dart';
import 'package:ai_project_management_tool/presentation/bloc/brief/brief_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAnalyzeBriefUseCase extends Mock implements AnalyzeBriefUseCase {}

class _MockExtractPdfUseCase extends Mock implements ExtractPdfUseCase {}

void main() {
  late _MockAnalyzeBriefUseCase analyzeBriefUseCase;
  late _MockExtractPdfUseCase extractPdfUseCase;

  setUp(() {
    analyzeBriefUseCase = _MockAnalyzeBriefUseCase();
    extractPdfUseCase = _MockExtractPdfUseCase();
  });

  blocTest<BriefBloc, BriefState>(
    'emits error when analyze fails',
    build: () {
      when(() => analyzeBriefUseCase.call(any())).thenAnswer(
        (_) async => const ApiFailure<BriefAnalysisResponseModel>('failed'),
      );
      return BriefBloc(
        analyzeBriefUseCase: analyzeBriefUseCase,
        extractPdfUseCase: extractPdfUseCase,
      );
    },
    act: (BriefBloc bloc) => bloc.add(const AnalyzeBriefRequested(briefText: 'abc')),
    expect: () => <BriefState>[
      const BriefAnalyzing(),
      const BriefError('failed'),
    ],
  );
}
