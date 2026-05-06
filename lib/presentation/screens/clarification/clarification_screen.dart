import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators/validation.dart';
import '../../bloc/brief/brief_bloc.dart';
import '../../bloc/brief/brief_event.dart';
import '../../bloc/brief/brief_state.dart';
import '../../widgets/common/app_button.dart';

class ClarificationScreen extends StatefulWidget {
  const ClarificationScreen({required this.state, super.key});
  final BriefNeedsClarification state;

  @override
  State<ClarificationScreen> createState() => _ClarificationScreenState();
}

class _ClarificationScreenState extends State<ClarificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = <String, TextEditingController>{
      for (final String question in widget.state.questions)
        question: TextEditingController(),
    };
  }

  @override
  void dispose() {
    for (final TextEditingController controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.clarificationsHeader)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            const Text(AppStrings.clarificationsSubtext),
            const SizedBox(height: 16),
            ...widget.state.questions.map(
              (String question) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(question),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _controllers[question],
                      validator: (String? value) =>
                          Validation.requiredField(value, AppStrings.requiredField),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            AppButton(
              label: AppStrings.submitAndGenerate,
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                context.read<BriefBloc>().add(
                      ClarificationsSubmitted(
                        _controllers.map(
                          (String key, TextEditingController value) =>
                              MapEntry<String, String>(key, value.text.trim()),
                        ),
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
