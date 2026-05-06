import '../../data/managers/dio/data_source.dart';
import '../../data/models/api_result.dart';
import '../repositories/brief_repository.dart';

class AnalyzeBriefUseCase {
  AnalyzeBriefUseCase(this._repository);

  final BriefRepository _repository;

  Future<ApiResult<BriefAnalysisResponseModel>> call(String briefText) {
    return _repository.analyzeBrief(briefText);
  }
}
