import 'dart:ui';
import 'package:flowery/core/cubits/locale/locale_events.dart';
import 'package:flowery/core/cubits/locale/locale_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../config/helpers/shared_preferences/shared_preferences_helper.dart';

@injectable
class LocaleCubit extends Cubit<LocaleState> {
  final SharedPreferencesHelper sharedPreferencesHelper;
  LocaleCubit(this.sharedPreferencesHelper)
    : super(
        LocaleState(
          locale: Locale(sharedPreferencesHelper.getString('locale') ?? 'en'),
        ),
      );

  void doEvent(LocaleEvents event) {
    switch (event) {
      case ChangeLocaleEvent():
        _changeLocale();
      case GetCurrentLocaleEvent():
        _getLocale();
    }
  }

  void _changeLocale() {
    final lanCode = state.locale.languageCode;
    final newLocale = lanCode == 'en' ? 'ar' : 'en';

    sharedPreferencesHelper.saveString(key: 'locale', value: newLocale);

    emit(state.copyWith(locale: Locale(newLocale)));
  }

  String? _getLocale() {
    return sharedPreferencesHelper.getString('locale');
  }
}
