import 'package:showcase_app/models/welcome.dart';
import 'package:showcase_app/services/welcome_api_client.dart';

class WelcomeRepo {
  WelcomeRepo({WelcomeApiClient? welcomeApiClient})
      : _welcomeApiClient = welcomeApiClient ?? WelcomeApiClient();

  final WelcomeApiClient _welcomeApiClient;

  Future<Welcome> getWelcomeMessage() async {
    final data = await _welcomeApiClient.getWelcomeMessage();
    final welcome = data.map((json) => Welcome.fromJson(json));
    return welcome;
  }
}
