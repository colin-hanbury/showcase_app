import 'dart:developer';

import 'package:showcase_app/services/welcome_api.dart';

class WelcomeRepo {
  WelcomeRepo({WelcomeAPI? welcomeApi})
      : _welcomeAPI = welcomeApi ?? WelcomeAPI();

  final WelcomeAPI _welcomeAPI;

  Future<String?> getWelcomeMessage(String id) async {
    try {
      final response = await _welcomeAPI.getWelcomeMessage(id);
      final message = response['message'];
      return message;
    } catch (error) {
      log(error.toString());
      return null;
    }
  }
}
