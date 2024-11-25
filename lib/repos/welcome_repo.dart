import 'dart:developer';

import 'package:showcase_app/models/welcome.dart';
import 'package:showcase_app/services/welcome_api.dart';

class WelcomeRepo {
  WelcomeRepo({WelcomeAPI? welcomeApi})
      : _welcomeAPI = welcomeApi ?? WelcomeAPI();

  final WelcomeAPI _welcomeAPI;

  Future<Welcome> getWelcomeMessage() async {
    try {
      final data = await _welcomeAPI.getWelcomeMessage();
      final welcomeMessage = data["welcomeMessage"];
      final welcome = Welcome(
        title: welcomeMessage['title'],
        message: welcomeMessage['message'],
      );
      return welcome;
    } catch (error) {
      log(error.toString());
      return Welcome(title: null, message: null);
    }
  }
}
