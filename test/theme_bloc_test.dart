import 'package:ai_project_management_tool/presentation/bloc/theme/theme_bloc.dart';
import 'package:ai_project_management_tool/presentation/bloc/theme/theme_event.dart';
import 'package:ai_project_management_tool/presentation/bloc/theme/theme_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThemeBloc', () {
    blocTest<ThemeBloc, ThemeState>(
      'emits updated dark mode state',
      build: ThemeBloc.new,
      act: (ThemeBloc bloc) => bloc.add(const ThemeChanged(false)),
      expect: () => <ThemeState>[const ThemeState(isDark: false)],
    );
  });
}
