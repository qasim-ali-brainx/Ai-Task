class AppStrings {
  const AppStrings._();

  static const String appName = 'BriefToJira';
  static const String homeHeadline =
      'Turn Client Briefs into Developer-Ready Jira Tickets — Instantly';
  static const String homeSubtext =
      'Upload a PDF client brief. Our AI analyzes it, asks clarifying questions if needed, and generates precise, unambiguous Jira tickets your dev team can act on immediately.';
  static const String uploadClientBrief = 'Upload Client Brief';
  static const String pdfBriefUpload = 'PDF brief upload';
  static const String aiPoweredAnalysis = 'AI-powered analysis';
  static const String structuredJiraTickets = 'Structured Jira tickets';
  static const String reUpload = 'Re-upload';
  static const String analyzeBrief = 'Analyze Brief';
  static const String extractingText = 'Extracting text from PDF...';
  static const String analyzingWithAi = 'Analyzing brief with AI...';
  static const String checkingAmbiguities = 'Checking for ambiguities...';
  static const String clarificationsHeader = 'A few things need clarification';
  static const String clarificationsSubtext =
      'To generate accurate tickets, please answer the following:';
  static const String submitAndGenerate = 'Submit & Generate Tickets';
  static const String generatedTickets = 'Generated Tickets';
  static const String copyAll = 'Copy All';
  static const String description = 'Description';
  static const String acceptanceCriteria = 'Acceptance Criteria';
  static const String technicalNotes = 'Technical Notes';
  static const String copyTicket = 'Copy Ticket';
  static const String shareTicket = 'Share';
  static const String noTicketsGenerated =
      'No tickets generated. Try re-uploading your brief.';
  static const String unknownRoute = 'Page not found';
  static const String retry = 'Retry';
  static const String parsePdfError =
      'Could not extract text from this PDF. Please ensure it is not a scanned image.';
  static const String longBriefWarning =
      'Brief is very long. Only the first section will be analyzed.';
  static const String requiredField = 'This field is required';
  static const String systemPrompt = '''
You are an expert PMO analyst and senior software architect. Your job is to convert client briefs into precise, developer-ready Jira tickets.

Rules you MUST follow:
1. NEVER make assumptions. If information is missing or ambiguous, return a JSON object with "needsClarification": true and a list of specific questions under "clarifications".
2. If the brief is complete, return "needsClarification": false and generate tickets.
3. Each ticket must have: title, description, acceptanceCriteria (array), priority (High/Medium/Low), complexityPoints (1/2/3/5/8), and technicalNotes.
4. Use clear, unambiguous developer language.
5. Break down complex features into the smallest independently deliverable tasks.
6. Always respond with valid JSON only. No prose, no markdown fences.
''';
}
