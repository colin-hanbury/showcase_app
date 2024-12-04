import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcase_app/blocs/actions/actions_event.dart';
import 'package:showcase_app/blocs/actions/actions_state.dart';
import 'package:showcase_app/models/user.dart';
import 'package:showcase_app/repos/actions_repo.dart';

class ActionsBloc extends Bloc<ActionsEvent, ActionsState> {
  ActionsBloc({required this.actionsRepo}) : super(ActionsState()) {
    on<SubmitDetails>(
        postSubmitDetails as EventHandler<SubmitDetails, ActionsState>);
  }

  final ActionsRepo actionsRepo;

  Future<void> postSubmitDetails(
      SubmitDetails event, Emitter<ActionsState> emitter) async {
    emitter(state.copyWith(status: ActionsStatus.loading));
    try {
      final User? user = await actionsRepo.submitDetails(
        event.user,
      );
      validateUserData(user);
      await storeUserData(user!);
      emitter(
        state.copyWith(
          status: ActionsStatus.success,
          user: user,
        ),
      );
    } catch (e) {
      emitter(state.copyWith(status: ActionsStatus.error, user: null));
    }
  }

  void validateUserData(User? user) {
    if (user != null ||
        user?.id != null ||
        user?.name != null ||
        user?.nationality != null) {
      if (user!.id.isNotEmpty ||
          user.name.isNotEmpty ||
          user.nationality.isNotEmpty) return;
    }
    throw Exception("No user returned");
  }

  Future<void> storeUserData(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', user.id);
  }
}
