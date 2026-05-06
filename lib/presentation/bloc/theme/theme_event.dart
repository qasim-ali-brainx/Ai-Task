import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class ThemeChanged extends ThemeEvent {
  const ThemeChanged(this.isDark);
  final bool isDark;

  @override
  List<Object?> get props => <Object?>[isDark];
}
