// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `카운터 명`
  String get add_counter_title {
    return Intl.message(
      '카운터 명',
      name: 'add_counter_title',
      desc: '',
      args: [],
    );
  }

  /// `카운터 색상`
  String get add_counter_color_text {
    return Intl.message(
      '카운터 색상',
      name: 'add_counter_color_text',
      desc: '',
      args: [],
    );
  }

  /// `시작 값`
  String get add_counter_start_point {
    return Intl.message(
      '시작 값',
      name: 'add_counter_start_point',
      desc: '',
      args: [],
    );
  }

  /// `증가 값`
  String get add_counter_increase_value {
    return Intl.message(
      '증가 값',
      name: 'add_counter_increase_value',
      desc: '',
      args: [],
    );
  }

  /// `카운터 방법`
  String get add_counter_method {
    return Intl.message(
      '카운터 방법',
      name: 'add_counter_method',
      desc: '',
      args: [],
    );
  }

  /// `버튼 방식`
  String get add_counter_button_method {
    return Intl.message(
      '버튼 방식',
      name: 'add_counter_button_method',
      desc: '',
      args: [],
    );
  }

  /// `화면 터치 방식`
  String get add_counter_screen_method {
    return Intl.message(
      '화면 터치 방식',
      name: 'add_counter_screen_method',
      desc: '',
      args: [],
    );
  }

  /// `완료`
  String get bottom_sheet_confirm {
    return Intl.message(
      '완료',
      name: 'bottom_sheet_confirm',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
