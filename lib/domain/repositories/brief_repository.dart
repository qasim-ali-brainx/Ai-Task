import '../../data/models/api_result.dart';
import '../../data/managers/dio/data_source.dart';

abstract class BriefRepository {
  Future<ApiResult<BriefAnalysisResponseModel>> analyzeBrief(String text);
  Future<ApiResult<String>> extractPdfText(String filePath);
}
