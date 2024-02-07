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

  /// `Hello World!`
  String get helloWorld {
    return Intl.message(
      'Hello World!',
      name: 'helloWorld',
      desc: 'The conventional newborn programmer greeting',
      args: [],
    );
  }

  /// `day`
  String get day {
    return Intl.message(
      'day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `ago`
  String get ago {
    return Intl.message(
      'ago',
      name: 'ago',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get minute {
    return Intl.message(
      'minute',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `hour`
  String get hour {
    return Intl.message(
      'hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `second`
  String get second {
    return Intl.message(
      'second',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `Anywhere you are`
  String get anywhere_you_are {
    return Intl.message(
      'Anywhere you are',
      name: 'anywhere_you_are',
      desc: '',
      args: [],
    );
  }

  /// `Sell houses easily with the help of Listenoryx and to make this line big\nI am writing more`
  String get sell_houses_easily_with_the_help_of_Listenoryx {
    return Intl.message(
      'Sell houses easily with the help of Listenoryx and to make this line big\nI am writing more',
      name: 'sell_houses_easily_with_the_help_of_Listenoryx',
      desc: '',
      args: [],
    );
  }

  /// `At anytime`
  String get at_anytime {
    return Intl.message(
      'At anytime',
      name: 'at_anytime',
      desc: '',
      args: [],
    );
  }

  /// `Book your car`
  String get book_your_car {
    return Intl.message(
      'Book your car',
      name: 'book_your_car',
      desc: '',
      args: [],
    );
  }

  /// `Enable your location`
  String get enable_your_location {
    return Intl.message(
      'Enable your location',
      name: 'enable_your_location',
      desc: '',
      args: [],
    );
  }

  /// `Choose your location to start find the request around you`
  String get choose_your_location_to_start {
    return Intl.message(
      'Choose your location to start find the request around you',
      name: 'choose_your_location_to_start',
      desc: '',
      args: [],
    );
  }

  /// `Use my location`
  String get use_my_location {
    return Intl.message(
      'Use my location',
      name: 'use_my_location',
      desc: '',
      args: [],
    );
  }

  /// `Skip for now`
  String get skip_for_now {
    return Intl.message(
      'Skip for now',
      name: 'skip_for_now',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get Welcome {
    return Intl.message(
      'Welcome',
      name: 'Welcome',
      desc: '',
      args: [],
    );
  }

  /// `Have a better sharing experience`
  String get have_a_better_sharing_experience {
    return Intl.message(
      'Have a better sharing experience',
      name: 'have_a_better_sharing_experience',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get create_an_account {
    return Intl.message(
      'Create an account',
      name: 'create_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get log_in {
    return Intl.message(
      'Log In',
      name: 'log_in',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `GO`
  String get go {
    return Intl.message(
      'GO',
      name: 'go',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
