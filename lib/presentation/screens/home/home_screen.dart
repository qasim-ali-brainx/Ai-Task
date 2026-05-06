import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/view_constants.dart';
import '../../bloc/brief/brief_bloc.dart';
import '../../bloc/brief/brief_event.dart';
import '../../widgets/common/app_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appName)),
      body: Padding(
        padding: const EdgeInsets.all(ViewConstants.spacingXl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Icon(AppIcons.appLogo, size: 72),
            const SizedBox(height: ViewConstants.spacingLg),
            Text(AppStrings.homeHeadline, style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: ViewConstants.spacingMd),
            Text(AppStrings.homeSubtext),
            const SizedBox(height: ViewConstants.spacingXl),
            const _FeatureRow(icon: AppIcons.uploadPdf, label: AppStrings.pdfBriefUpload),
            const _FeatureRow(icon: AppIcons.aiAnalysis, label: AppStrings.aiPoweredAnalysis),
            const _FeatureRow(icon: AppIcons.jiraTickets, label: AppStrings.structuredJiraTickets),
            const Spacer(),
            AppButton(
              label: AppStrings.uploadClientBrief,
              onPressed: () async {
                final FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: <String>['pdf'],
                );
                if (result?.files.single.path == null || !context.mounted) {
                  return;
                }
                context
                    .read<BriefBloc>()
                    .add(BriefFileSelected(result!.files.single.path!));
                context.push(AppRoutes.pdfPreview);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ViewConstants.spacingSm),
      child: Row(
        children: <Widget>[
          Icon(icon),
          const SizedBox(width: ViewConstants.spacingSm),
          Text(label),
        ],
      ),
    );
  }
}
