import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/constants/app_strings.dart';
import '../../bloc/brief/brief_bloc.dart';
import '../../bloc/brief/brief_state.dart';
import '../../bloc/ticket/ticket_bloc.dart';
import '../../bloc/ticket/ticket_event.dart';
import '../../widgets/common/loaders.dart';

class ProcessingScreen extends StatelessWidget {
  const ProcessingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BriefBloc, BriefState>(
      listener: (BuildContext context, BriefState state) {
        if (state is BriefNeedsClarification) {
          context.go(AppRoutes.clarification, extra: state);
        } else if (state is BriefComplete) {
          context.read<TicketBloc>().add(TicketLoaded(state.tickets));
          context.go(AppRoutes.ticketList);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Loaders.processingIndicator(),
              const SizedBox(height: 24),
              const Text(AppStrings.extractingText),
              const Text(AppStrings.analyzingWithAi),
              const Text(AppStrings.checkingAmbiguities),
            ],
          ),
        ),
      ),
    );
  }
}
