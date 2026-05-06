import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/formatters/formatter.dart';
import '../../bloc/brief/brief_bloc.dart';
import '../../bloc/brief/brief_event.dart';
import '../../bloc/brief/brief_state.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/error_widget.dart';

class PdfPreviewScreen extends StatelessWidget {
  const PdfPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<BriefBloc, BriefState>(
        builder: (BuildContext context, BriefState state) {
          if (state is BriefExtracting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BriefError) {
            return AppErrorWidget(message: state.message, onRetry: () => context.pop());
          }
          if (state is! BriefFilePicked) {
            return AppErrorWidget(message: AppStrings.parsePdfError, onRetry: () => context.pop());
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(state.fileName, style: Theme.of(context).textTheme.titleLarge),
                Text(Formatter.bytesToReadable(state.fileSizeBytes)),
                const SizedBox(height: 12),
                Expanded(
                  child: Card(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
                      child: Text(state.previewText),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: AppButton(
                        label: AppStrings.reUpload,
                        onPressed: () => context.pop(),
                        isOutlined: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton(
                        label: AppStrings.analyzeBrief,
                        onPressed: () {
                          context
                              .read<BriefBloc>()
                              .add(AnalyzeBriefRequested(briefText: state.fullText));
                          context.push(AppRoutes.processing);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
