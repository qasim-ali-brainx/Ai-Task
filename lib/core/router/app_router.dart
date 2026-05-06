import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_routes.dart';
import '../constants/app_strings.dart';
import '../../domain/models/ticket_entity.dart';
import '../../presentation/bloc/brief/brief_state.dart';
import '../../presentation/screens/clarification/clarification_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/pdf_preview/pdf_preview_screen.dart';
import '../../presentation/screens/processing/processing_screen.dart';
import '../../presentation/screens/ticket_detail/ticket_detail_screen.dart';
import '../../presentation/screens/ticket_list/ticket_list_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.home,
      builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.pdfPreview,
      builder: (BuildContext context, GoRouterState state) => const PdfPreviewScreen(),
    ),
    GoRoute(
      path: AppRoutes.processing,
      builder: (BuildContext context, GoRouterState state) => const ProcessingScreen(),
    ),
    GoRoute(
      path: AppRoutes.clarification,
      builder: (_, GoRouterState state) {
        final BriefNeedsClarification clarificationState =
            state.extra! as BriefNeedsClarification;
        return ClarificationScreen(state: clarificationState);
      },
    ),
    GoRoute(
      path: AppRoutes.ticketList,
      builder: (BuildContext context, GoRouterState state) => const TicketListScreen(),
    ),
    GoRoute(
      path: AppRoutes.ticketDetail,
      builder: (_, GoRouterState state) {
        final TicketEntity ticket = state.extra! as TicketEntity;
        return TicketDetailScreen(ticket: ticket);
      },
    ),
  ],
  errorBuilder: (BuildContext context, GoRouterState state) =>
      const _RoutePlaceholder(title: AppStrings.unknownRoute),
);

class _RoutePlaceholder extends StatelessWidget {
  const _RoutePlaceholder({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
