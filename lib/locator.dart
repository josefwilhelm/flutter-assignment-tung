import 'package:get_it/get_it.dart';
import 'package:flutter_assessment/services/auth_service.dart';
import 'package:flutter_assessment/services/firebase_service.dart';

GetIt getIt = GetIt.instance;

setupLocator() {
  getIt.registerSingleton(FirebaseService());
  getIt.registerSingleton(AuthService());
}
