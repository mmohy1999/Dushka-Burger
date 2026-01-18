import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit(Locale locale) : super(LocaleState(locale));

  Future<void> setLocale(BuildContext context, Locale locale) async {
    if (state.locale == locale) {
      emit(LocaleState(locale));
      return;
    }
    await context.setLocale(locale);
    emit(LocaleState(locale));
  }

  void sync(Locale locale) {
    if (state.locale == locale) return;
    emit(LocaleState(locale));
  }

  void refresh() => emit(LocaleState(state.locale));
}
