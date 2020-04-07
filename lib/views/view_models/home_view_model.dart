import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_assessment/locator.dart';
import 'package:flutter_assessment/router.dart';
import 'package:flutter_assessment/services/auth_service.dart';

class HomeViewModel extends ChangeNotifier {
  Stream<List<Route>> list;
  onLogoutPressed() {
    getIt<AuthService>().logout();
  }
}
