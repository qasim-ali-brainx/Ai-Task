# Cursor Prompt: AI-Powered Client Brief → Jira Ticket Converter (Flutter)

## Project Overview

Build a Flutter mobile application for the PMO department that converts raw client briefs (uploaded as PDFs) into structured, developer-ready Jira-style tickets using the OpenAI API (GPT-4.1 mini). The app must never make assumptions — if a brief is ambiguous, it must surface clarifying questions before generating tickets.

---

## Tech Stack

- **Flutter** (latest stable)
- **State Management**: flutter_bloc / bloc
- **HTTP Client**: Dio
- **PDF Handling**: file_picker + syncfusion_flutter_pdf (for text extraction)
- **Architecture**: Clean Architecture (presentation → domain → data)
- **Theme**: Dark mode only (for MVP)

---

## Project Folder Structure

Strictly follow this structure:

```
lib/
├── main.dart
├── core/
│   ├── constants/
│   │   ├── api_end_points.dart       # Base URLs and endpoint paths
│   │   ├── app_constants.dart        # App-wide constants (timeouts, limits, etc.)
│   │   ├── app_icons.dart            # Icon asset paths or icon data constants
│   │   ├── app_routes.dart           # Named route strings
│   │   ├── app_strings.dart          # All UI strings (no hardcoded strings in widgets)
│   │   ├── color_constants.dart      # Static hex colors (raw palette only — no context)
│   │   ├── theme_constants.dart      # Spacing, border radius, font sizes, elevation
│   │   └── view_constants.dart       # Padding, margin, size constants
│   ├── router/
│   │   └── app_router.dart           # GoRouter or Navigator 2.0 route definitions
│   ├── theme/
│   │   ├── base_theme.dart           # Shared ThemeData properties
│   │   ├── dark_theme.dart           # Dark ThemeData (primary color: blue)
│   │   └── light_theme.dart          # Light ThemeData (placeholder for future)
│   └── utils/
│       ├── device/
│       │   └── device_utility.dart   # Screen size, platform helpers
│       ├── formatters/
│       │   └── formatter.dart        # Date, string, number formatters
│       ├── validators/
│       │   └── validation.dart       # Input validation helpers
│       └── helper_methods.dart       # Generic utility functions
├── data/
│   ├── managers/
│   │   ├── dio/
│   │   │   ├── api_manager.dart      # Central Dio instance + interceptors
│   │   │   ├── data_source.dart      # Abstract + concrete remote data source
│   │   │   ├── dio_factory.dart      # Dio configuration factory
│   │   │   ├── error_handler.dart    # Maps DioException codes to AppError
│   │   │   ├── failure.dart          # Failure sealed class / models
│   │   │   └── network_info.dart     # Connectivity checker
│   │   └── preferences/
│   │       └── preference_manager.dart  # SharedPreferences wrapper
│   ├── models/
│   │   ├── api_result.dart           # Generic ApiResult<T> success/failure wrapper
│   │   └── ticket_model.dart         # JiraTicket data model with fromJson/toJson
│   └── repositories/
│       └── brief_repository_impl.dart  # Implementation of domain repository
├── domain/
│   ├── models/
│   │   └── ticket_entity.dart        # Pure domain entity (no JSON logic)
│   ├── repositories/
│   │   └── brief_repository.dart     # Abstract repository interface
│   └── usecases/
│       ├── analyze_brief_usecase.dart    # Sends text to OpenAI, gets tickets
│       └── extract_pdf_usecase.dart      # Extracts text from a PDF file
└── presentation/
    ├── bloc/
    │   ├── theme/
    │   │   ├── theme_bloc.dart
    │   │   ├── theme_event.dart
    │   │   └── theme_state.dart
    │   ├── brief/
    │   │   ├── brief_bloc.dart        # PDF upload + AI analysis orchestration
    │   │   ├── brief_event.dart
    │   │   └── brief_state.dart
    │   └── ticket/
    │       ├── ticket_bloc.dart       # Ticket list + detail interactions
    │       ├── ticket_event.dart
    │       └── ticket_state.dart
    ├── screens/
    │   ├── home/
    │   │   └── home_screen.dart       # Landing screen with app intro + upload CTA
    │   ├── pdf_preview/
    │   │   └── pdf_preview_screen.dart
    │   ├── processing/
    │   │   └── processing_screen.dart
    │   ├── clarification/
    │   │   └── clarification_screen.dart
    │   ├── ticket_list/
    │   │   └── ticket_list_screen.dart
    │   └── ticket_detail/
    │       └── ticket_detail_screen.dart
    └── widgets/
        └── common/
            ├── full_screen_loader.dart
            ├── loaders.dart
            ├── error_widget.dart
            ├── app_button.dart        # Primary CTA button widget
            ├── app_chip.dart          # Priority / tag chip
            └── ticket_card.dart       # Reusable ticket summary card
```

---

## Design System

### Color Palette (`color_constants.dart`)
```dart
// Background
static const Color backgroundPrimary   = Color(0xFF1A1A2E);  // Dark navy
static const Color backgroundSecondary = Color(0xFF16213E);  // Slightly lighter
static const Color backgroundCard      = Color(0xFF0F3460);  // Card surface

// Primary
static const Color primaryBlue         = Color(0xFF4361EE);  // CTA buttons
static const Color primaryBlueLight    = Color(0xFF738EF5);  // Hover / focus states
static const Color accentCyan          = Color(0xFF4CC9F0);  // Highlights

// Status
static const Color statusSuccess       = Color(0xFF2DC653);
static const Color statusWarning       = Color(0xFFFFC300);
static const Color statusError         = Color(0xFFEF233C);
static const Color statusInfo          = Color(0xFF4361EE);

// Priority badge colors
static const Color priorityHigh        = Color(0xFFEF233C);
static const Color priorityMedium      = Color(0xFFFFC300);
static const Color priorityLow         = Color(0xFF2DC653);

// Text
static const Color textPrimary         = Color(0xFFEEEEEE);
static const Color textSecondary       = Color(0xFFAAAAAA);
static const Color textMuted           = Color(0xFF666680);

// Border / Divider
static const Color borderColor         = Color(0xFF2A2A4A);
```

### Dark Theme (`dark_theme.dart`)
- `scaffoldBackgroundColor`: `backgroundPrimary`
- `colorScheme.primary`: `primaryBlue`
- `cardColor`: `backgroundCard`
- `appBarTheme`: transparent, no elevation, white title text
- `elevatedButtonTheme`: rounded (12px radius), primaryBlue fill, white text
- `textTheme`: Use `textPrimary` for body, `textSecondary` for subtitles
- `dividerColor`: `borderColor`
- `inputDecorationTheme`: filled, `backgroundSecondary` fill, no border, 12px radius

### Typography
- Headings: `fontSize: 24`, `fontWeight: FontWeight.bold`
- Subheadings: `fontSize: 18`, `fontWeight: FontWeight.w600`
- Body: `fontSize: 14`, `fontWeight: FontWeight.normal`
- Caption: `fontSize: 12`, `color: textSecondary`

---

## Screen-by-Screen Requirements

### 1. Home Screen (`home_screen.dart`)

**Purpose**: First impression + educates the user on what the app does.

**UI Requirements**:
- App logo / icon at the top center
- App name: **"BriefToJira"** (or similar PMO-friendly name)
- Hero section with bold headline:
  > "Turn Client Briefs into Developer-Ready Jira Tickets — Instantly"
- Subtext (smaller, muted):
  > "Upload a PDF client brief. Our AI analyzes it, asks clarifying questions if needed, and generates precise, unambiguous Jira tickets your dev team can act on immediately."
- 3 feature highlights (icon + text rows):
    - 📄 "PDF brief upload"
    - 🤖 "AI-powered analysis"
    - 🎫 "Structured Jira tickets"
- Primary CTA button: **"Upload Client Brief"** (full width, bottom area)
- Tapping CTA triggers file picker for PDF only

**Bloc**: `BriefBloc` — emit `BriefInitial` on load, `BriefFileSelected` after pick

---

### 2. PDF Preview Screen (`pdf_preview_screen.dart`)

**Purpose**: Show the user what file they've selected before processing.

**UI Requirements**:
- File name (with PDF icon)
- File size
- Number of pages (if extractable)
- Short extracted text preview (first 300 chars) in a scrollable card
- Two buttons: **"Re-upload"** (outlined) | **"Analyze Brief"** (primary)

---

### 3. Processing Screen (`processing_screen.dart`)

**Purpose**: Visual feedback while the AI works.

**UI Requirements**:
- Animated loading indicator (e.g., pulsing circle or shimmer)
- Step indicators showing progress:
    1. "Extracting text from PDF..."
    2. "Analyzing brief with AI..."
    3. "Checking for ambiguities..."
- These steps update via BLoC state, not a timer

---

### 4. Clarification Screen (`clarification_screen.dart`)

**Purpose**: If the AI detects gaps, surface them for user input.

**UI Requirements**:
- Header: "A few things need clarification"
- Subtext: "To generate accurate tickets, please answer the following:"
- List of AI-generated questions, each with a `TextField` below it
- Validation: no field can be empty
- Button: **"Submit & Generate Tickets"**

**Bloc**: On submit, re-send enriched brief back to `BriefBloc` → `AnalyzeBrief`

---

### 5. Ticket List Screen (`ticket_list_screen.dart`)

**Purpose**: Display all generated tickets as scannable cards.

**UI Requirements**:
- Header: "Generated Tickets (N)" where N = count
- Filter chips at top: All | High | Medium | Low (by priority)
- Scrollable list of `TicketCard` widgets
- Each card shows:
    - Ticket title
    - Priority badge (colored chip: High/Medium/Low)
    - Estimated complexity tag (e.g., "3 SP")
    - First line of description (truncated)
- FAB or top-right button: **"Copy All"** (copies all tickets as JSON or plain text)

**Bloc**: `TicketBloc` handles filter selection — **do NOT rebuild entire list for filter tap**, use `BlocBuilder` scoped to just the filter row + list

---

### 6. Ticket Detail Screen (`ticket_detail_screen.dart`)

**Purpose**: Full view of a single generated ticket.

**UI Requirements**:
- Ticket title (large, bold)
- Priority badge + Complexity estimate (row)
- Section: **"Description"** — full text
- Section: **"Acceptance Criteria"** — bulleted list
- Section: **"Technical Notes"** (if AI provided any)
- Copy button (copies this ticket's content)
- Optional: Share button

---

## BLoC Architecture Rules

1. **Never emit `Loading` from `AppBloc`-level for small widget interactions** (e.g., filter chip selection). Use local state or a sub-BLoC.
2. **Use `BlocBuilder` with `buildWhen`** to prevent unnecessary rebuilds.
3. **Use `BlocListener`** for navigation side effects (e.g., navigate to ticket list after analysis completes).
4. **Use `Equatable`** on all states and events.
5. **Brief states**:
   ```
   BriefInitial → BriefFileSelected → BriefExtracting → BriefAnalyzing →
   BriefNeedsClarification → BriefAnalyzing (again) → BriefComplete | BriefError
   ```
6. **Ticket states**:
   ```
   TicketInitial → TicketLoaded(tickets, filter) → TicketFiltered(tickets)
   ```

---

## API Layer

### OpenAI Configuration (`api_end_points.dart`)
```dart
static const String openAiBaseUrl = 'https://api.openai.com/v1';
static const String chatCompletions = '/chat/completions';
```

### API Key (`app_constants.dart`)
```dart
// ⚠️ FOR MVP ONLY — move to env file or secure storage before production
static const String openAiApiKey = 'YOUR_OPENAI_API_KEY_HERE';
static const String openAiModel  = 'gpt-4.1-mini';
static const int    maxTokens    = 4096;
static const int    connectTimeoutMs = 30000;
static const int    receiveTimeoutMs = 60000;  // AI calls can be slow
```

### Dio Factory (`dio_factory.dart`)
```dart
// Configure with:
// - baseUrl: openAiBaseUrl
// - connectTimeout, receiveTimeout from constants
// - Headers: Content-Type: application/json, Authorization: Bearer <key>
// - LogInterceptor (debug only, never in release)
// - RetryInterceptor: 2 retries on 5xx only
```

### Error Handler (`error_handler.dart`)

Map ALL error cases with human-readable messages:

| Code / Type | User-Facing Message |
|---|---|
| 400 | "The request was invalid. Please try uploading again." |
| 401 | "API key is invalid or expired." |
| 429 | "Too many requests. Please wait a moment and try again." |
| 500, 502, 503 | "OpenAI service is temporarily unavailable. Try again later." |
| No internet | "No internet connection. Please check your network." |
| Timeout | "The request timed out. The brief may be too large — try a shorter one." |
| Parse error | "Unexpected response format. Please try again." |
| Unknown | "Something went wrong. Please try again." |

### `ApiResult<T>` (`api_result.dart`)
```dart
sealed class ApiResult<T> {
  const ApiResult();
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  const ApiSuccess(this.data);
}

class ApiFailure<T> extends ApiResult<T> {
  final String message;
  final int? statusCode;
  const ApiFailure(this.message, {this.statusCode});
}
```

---

## OpenAI Prompt Engineering

### System Prompt (stored in `app_strings.dart`)

```
You are an expert PMO analyst and senior software architect. Your job is to convert client briefs into precise, developer-ready Jira tickets.

Rules you MUST follow:
1. NEVER make assumptions. If information is missing or ambiguous, return a JSON object with "needsClarification": true and a list of specific questions under "clarifications".
2. If the brief is complete, return "needsClarification": false and generate tickets.
3. Each ticket must have: title, description, acceptanceCriteria (array), priority (High/Medium/Low), complexityPoints (1/2/3/5/8), and technicalNotes.
4. Use clear, unambiguous developer language.
5. Break down complex features into the smallest independently deliverable tasks.
6. Always respond with valid JSON only. No prose, no markdown fences.
```

### Response JSON Schema

```json
{
  "needsClarification": false,
  "clarifications": [],
  "tickets": [
    {
      "id": "TICKET-1",
      "title": "Implement user authentication flow",
      "description": "...",
      "acceptanceCriteria": ["Given...", "When...", "Then..."],
      "priority": "High",
      "complexityPoints": 5,
      "technicalNotes": "Use JWT with refresh tokens."
    }
  ]
}
```

---

## PDF Text Extraction

Use `syncfusion_flutter_pdf` to extract text page by page. Concatenate into a single string. If extracted text is empty, show an error: *"Could not extract text from this PDF. Please ensure it is not a scanned image."*

---

## Common Widgets

### `AppButton`
- Primary: filled blue, rounded 12px, full-width by default
- Secondary/outlined: transparent with blue border
- Loading state: replace label with `CircularProgressIndicator` (white, size 20)
- Disabled state: 40% opacity

### `TicketCard`
- Dark card (`backgroundCard`) with 12px radius
- Left border accent colored by priority (High=red, Medium=yellow, Low=green)
- Subtle press animation (scale down slightly on tap)

### `PriorityChip`
- Small pill badge, colored background (10% opacity of priority color), colored text

### `FullScreenLoader`
- Semi-transparent dark overlay + centered animated indicator
- Triggered via `BlocListener`, not inside `build()`

### `AppErrorWidget`
- Centered icon + error message + retry button
- Reusable across all screens

---

## Additional MVP Requirements (Do Not Miss)

### Navigation
- Use **GoRouter** for declarative routing
- Define all route names in `app_routes.dart` as constants
- Pass data between screens via route `extra` parameter, not global state

### Dependency Injection
- Use **`get_it`** for service locator
- Register all blocs, repositories, use cases, and managers in a central `injection_container.dart` file at lib root
- Blocs must be registered as **factory** (new instance per screen)
- Repositories and managers as **singleton**

### Error Boundaries
- Every screen must handle `BriefError` and `TicketError` states gracefully with `AppErrorWidget` + retry
- Never let an unhandled exception crash the app silently

### Loading States
- Every async operation must show a loading indicator
- Loading must be dismissible — never block UI permanently if a request hangs beyond `receiveTimeout`

### Graceful Empty States
- Ticket list with 0 tickets: show an empty state illustration + message "No tickets generated. Try re-uploading your brief."

### Copy & Export
- Copy single ticket: formatted plain text (title, description, criteria)
- Copy all tickets: JSON array or formatted multi-ticket text block
- Use `flutter/services.dart` `Clipboard.setData`

### Input Limits
- PDF text extraction: cap at **12,000 characters** before sending to API (to stay within token limits). If exceeded, warn user: *"Brief is very long. Only the first section will be analyzed."*

### `pubspec.yaml` Dependencies
```yaml
dependencies:
  flutter_bloc: ^8.1.6
  equatable: ^2.0.5
  dio: ^5.4.3
  get_it: ^7.7.0
  go_router: ^14.0.0
  file_picker: ^8.0.0
  syncfusion_flutter_pdf: ^26.1.40
  shared_preferences: ^2.2.3
  connectivity_plus: ^6.0.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.7
  mocktail: ^1.0.4
```

### `.gitignore` Additions
```
# Build outputs
build/
.dart_tool/
.packages

# IDE
.idea/
.vscode/
*.iml

# Keys (never commit real keys)
*.env
secrets.dart

# OS
.DS_Store
Thumbs.db

# Flutter
*.g.dart
*.freezed.dart
pubspec.lock   # optional — include if you want reproducible builds
```

---

## Implementation Order (Follow Strictly)

1. **Project setup** — folder structure, pubspec, get_it injection setup
2. **Core layer** — constants, theme (dark), router, utils
3. **Data layer** — Dio factory, API manager, error handler, `ApiResult`, models
4. **Domain layer** — entities, repository interface, use cases
5. **Data layer (impl)** — repository implementation, data source
6. **Presentation — BLoC** — theme bloc, brief bloc, ticket bloc
7. **Presentation — Widgets** — common widgets first
8. **Presentation — Screens** — home → pdf preview → processing → clarification → ticket list → ticket detail
9. **Wiring** — connect blocs to screens, register in get_it, set up GoRouter
10. **Polish** — animations, empty states, error states, copy functionality

---

## Quality Checklist Before Completion

- [ ] No hardcoded strings in any widget — all in `app_strings.dart`
- [ ] No hardcoded colors in widgets — all via `Theme.of(context)` or `ColorConstants`
- [ ] No hardcoded padding values — all via `ViewConstants`
- [ ] Every BLoC state has `Equatable` and `props` implemented
- [ ] Every screen handles: initial, loading, success, error, and empty states
- [ ] No `print()` statements — use `debugPrint()` wrapped in `kDebugMode`
- [ ] API key is in constants with a `// TODO: move to secure storage` comment
- [ ] GoRouter handles unknown routes with a 404-style fallback screen
- [ ] App works on both Android and iOS (no platform-specific hacks)
- [ ] Minimum viable test: at least one bloc_test per BLoC

---

*This prompt is intended for use in Cursor AI. Implement one layer at a time, validate structure before moving to the next, and do not skip the quality checklist.*
