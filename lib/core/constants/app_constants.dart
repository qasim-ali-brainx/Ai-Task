import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  const AppConstants._();

  // TODO: move to secure storage.
  static String get openAiApiKey => dotenv.env['OPENAI_API_KEY'] ?? '';
  static const String openAiModel = 'gpt-4.1-mini';
  static const int maxTokens = 4096;
  static const int connectTimeoutMs = 30000;
  static const int receiveTimeoutMs = 60000;
  static const int maxExtractedCharacters = 12000;
  static const int pdfPreviewCharacterCount = 300;
}
