// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "home_appTitle" : MessageLookupByLibrary.simpleMessage("Home Screen"),
    "login_email" : MessageLookupByLibrary.simpleMessage("Email"),
    "login_emailError" : MessageLookupByLibrary.simpleMessage("Not a valid email address"),
    "login_loginButtonTitle" : MessageLookupByLibrary.simpleMessage("Log in"),
    "login_password" : MessageLookupByLibrary.simpleMessage("Password"),
    "login_passwordError" : MessageLookupByLibrary.simpleMessage("Password needs to have at least 6 characters and 1 number"),
    "login_signUp" : MessageLookupByLibrary.simpleMessage("Sign Up"),
    "register_backToLogin1" : MessageLookupByLibrary.simpleMessage("Back to Login"),
    "register_firstName" : MessageLookupByLibrary.simpleMessage("First name"),
    "register_firstNameError" : MessageLookupByLibrary.simpleMessage("First name"),
    "register_lastName" : MessageLookupByLibrary.simpleMessage("Last name")
  };
}
