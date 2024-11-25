import 'dart:developer';

import 'package:showcase_app/models/visitor.dart';
import 'package:showcase_app/services/actions_api.dart';

class ActionsRepo {
  ActionsRepo({ActionsAPI? actionsAPI})
      : _actionsAPI = actionsAPI ?? ActionsAPI();

  final ActionsAPI _actionsAPI;

  Future<bool> submitDetails(Visitor visitor) async {
    try {
      final response = await _actionsAPI.postActions(visitor);
      return response['success'] == 'false'
          ? throw Exception([
              response['error'] ?? 'upload error',
            ])
          : true;
    } catch (error) {
      log(error.toString());
      return false;
    }
  }
}
