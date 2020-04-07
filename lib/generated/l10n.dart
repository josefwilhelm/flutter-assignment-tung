// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get home_appTitle {
    return Intl.message(
      'Home Screen',
      name: 'home_appTitle',
      desc: '',
      args: [],
    );
  }

  String get login_email {
    return Intl.message(
      'Email',
      name: 'login_email',
      desc: '',
      args: [],
    );
  }

  String get login_emailError {
    return Intl.message(
      'Not a valid email address',
      name: 'login_emailError',
      desc: '',
      args: [],
    );
  }

  String get login_password {
    return Intl.message(
      'Password',
      name: 'login_password',
      desc: '',
      args: [],
    );
  }

  String get login_passwordError {
    return Intl.message(
      'Password needs to have at least 6 characters and 1 number',
      name: 'login_passwordError',
      desc: '',
      args: [],
    );
  }

  String get login_loginButtonTitle {
    return Intl.message(
      'Log in',
      name: 'login_loginButtonTitle',
      desc: '',
      args: [],
    );
  }

  String get login_signUp {
    return Intl.message(
      'Sign Up',
      name: 'login_signUp',
      desc: '',
      args: [],
    );
  }

  String get register_firstName {
    return Intl.message(
      'First name',
      name: 'register_firstName',
      desc: '',
      args: [],
    );
  }

  String get register_firstNameError {
    return Intl.message(
      'First name',
      name: 'register_firstNameError',
      desc: '',
      args: [],
    );
  }

  String get register_lastName {
    return Intl.message(
      'Last name',
      name: 'register_lastName',
      desc: '',
      args: [],
    );
  }

  String get register_backToLogin1 {
    return Intl.message(
      'Back to Login',
      name: 'register_backToLogin1',
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
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}