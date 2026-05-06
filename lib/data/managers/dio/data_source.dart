import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/constants/api_end_points.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../models/api_result.dart';
import '../../models/ticket_model.dart';
import 'api_manager.dart';
import 'error_handler.dart';

abstract class BriefRemoteDataSource {
  Future<ApiResult<BriefAnalysisResponseModel>> analyzeBrief(String text);
}

class BriefAnalysisResponseModel {
  const BriefAnalysisResponseModel({
    required this.needsClarification,
    required this.clarifications,
    required this.tickets,
  });

  final bool needsClarification;
  final List<String> clarifications;
  final List<TicketModel> tickets;
}

class BriefRemoteDataSourceImpl implements BriefRemoteDataSource {
  BriefRemoteDataSourceImpl(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<ApiResult<BriefAnalysisResponseModel>> analyzeBrief(String text) async {
    try {
      final Response<dynamic> response = await _apiManager.post(
        path: ApiEndPoints.chatCompletions,
        data: <String, dynamic>{
          'model': AppConstants.openAiModel,
          'max_tokens': AppConstants.maxTokens,
          'messages': <Map<String, String>>[
            <String, String>{'role': 'system', 'content': AppStrings.systemPrompt},
            <String, String>{'role': 'user', 'content': text},
          ],
        },
      );

      final String content =
          ((response.data as Map<String, dynamic>)['choices'] as List<dynamic>)
                  .first['message']['content']
                  .toString();
      final Map<String, dynamic> parsed = jsonDecode(content) as Map<String, dynamic>;

      final List<TicketModel> tickets =
          (parsed['tickets'] as List<dynamic>? ?? <dynamic>[])
              .map(
                (dynamic item) =>
                    TicketModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();

      return ApiSuccess<BriefAnalysisResponseModel>(
        BriefAnalysisResponseModel(
          needsClarification: parsed['needsClarification'] as bool? ?? false,
          clarifications:
              (parsed['clarifications'] as List<dynamic>? ?? <dynamic>[])
                  .map((dynamic item) => item.toString())
                  .toList(),
          tickets: tickets,
        ),
      );
    } catch (error) {
      final failure = ErrorHandler.mapException(error);
      return ApiFailure<BriefAnalysisResponseModel>(
        failure.message,
        statusCode: failure.statusCode,
      );
    }
  }
}
