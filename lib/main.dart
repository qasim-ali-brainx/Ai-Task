import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/router/app_router.dart';
import 'core/theme/dark_theme.dart';
import 'injection_container.dart' as di;
import 'presentation/bloc/brief/brief_bloc.dart';
import 'presentation/bloc/theme/theme_bloc.dart';
import 'presentation/bloc/theme/theme_state.dart';
import 'presentation/bloc/ticket/ticket_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await di.initDependencies();
  runApp(const BriefToJiraApp());
}

class BriefToJiraApp extends StatelessWidget {
  const BriefToJiraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<ThemeBloc>(create: (_) => di.sl<ThemeBloc>()),
        BlocProvider<BriefBloc>(create: (_) => di.sl<BriefBloc>()),
        BlocProvider<TicketBloc>(create: (_) => di.sl<TicketBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'BriefToJira',
            theme: darkTheme(),
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
