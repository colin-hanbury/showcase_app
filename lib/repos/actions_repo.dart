import 'dart:developer';

import 'package:showcase_app/models/user.dart';
import 'package:showcase_app/services/actions_api.dart';

class ActionsRepo {
  ActionsRepo({ActionsAPI? actionsAPI})
      : _actionsAPI = actionsAPI ?? ActionsAPI();

  final ActionsAPI _actionsAPI;

  Future<User?> submitDetails(User visitor) async {
    try {
      final response = await _actionsAPI.postActions(visitor);
      final responseData = response["user"];
      final user = User(
        id: responseData['_id'],
        name: responseData['name'],
        nationality: responseData['nationality'],
      );
      return user;
    } catch (error) {
      log(error.toString());
      return null;
    }
  }
}
