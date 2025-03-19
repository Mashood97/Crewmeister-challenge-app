import 'package:absence_manager_app/utils/theme/theme_type.dart';
import 'package:absence_manager_app/utils/theme/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  Future<void> changeThemeType(ThemeType type) async {
    emit(state.copyWith(selectedThemeType: type));
  }

  Future<void> changeThemeMode(ThemeMode mode) async {
    emit(state.copyWith(themeMode: mode));
  }
}
