import 'dart:io';

import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/repositories/brief_repository.dart';
import '../managers/dio/data_source.dart';
import '../models/api_result.dart';

class BriefRepositoryImpl implements BriefRepository {
  BriefRepositoryImpl(this._remoteDataSource);

  final BriefRemoteDataSource _remoteDataSource;

  @override
  Future<ApiResult<BriefAnalysisResponseModel>> analyzeBrief(String text) {
    return _remoteDataSource.analyzeBrief(text);
  }

  @override
  Future<ApiResult<String>> extractPdfText(String filePath) async {
    try {
      final List<int> bytes = await File(filePath).readAsBytes();
      final PdfDocument document = PdfDocument(inputBytes: bytes);
      final PdfTextExtractor extractor = PdfTextExtractor(document);
      final StringBuffer extractedText = StringBuffer();

      for (int page = 1; page <= document.pages.count; page++) {
        extractedText.write(extractor.extractText(startPageIndex: page - 1));
        extractedText.write('\n');
      }
      document.dispose();

      String result = extractedText.toString().trim();
      if (result.isEmpty) {
        return const ApiFailure<String>(AppStrings.parsePdfError);
      }
      if (result.length > AppConstants.maxExtractedCharacters) {
        result = result.substring(0, AppConstants.maxExtractedCharacters);
      }
      return ApiSuccess<String>(result);
    } catch (_) {
      return const ApiFailure<String>(AppStrings.parsePdfError);
    }
  }
}
