import '../../data/models/api_result.dart';
import '../repositories/brief_repository.dart';

class ExtractPdfUseCase {
  ExtractPdfUseCase(this._repository);

  final BriefRepository _repository;

  Future<ApiResult<String>> call(String filePath) {
    return _repository.extractPdfText(filePath);
  }
}
