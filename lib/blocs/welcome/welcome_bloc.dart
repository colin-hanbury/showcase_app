import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcase_app/blocs/welcome/welcome_event.dart';
import 'package:showcase_app/blocs/welcome/welcome_state.dart';
import 'package:showcase_app/repos/welcome_repo.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc({required this.welcomeRepo}) : super(WelcomeState()) {
    on<GetWelcomeMessage>(getWelcomeMessage);
  }

  final WelcomeRepo welcomeRepo;

  Future<void> getWelcomeMessage(
      GetWelcomeMessage event, Emitter<WelcomeState> emitter) async {
    emitter(state.copyWith(status: WelcomeStatus.loading));
    try {
      final userID = await getUserId();
      final message = await welcomeRepo.getWelcomeMessage(userID);
      emitter(
        state.copyWith(
          status: WelcomeStatus.success,
          message: message,
        ),
      );
    } catch (error) {
      emitter(
        state.copyWith(
          status: WelcomeStatus.error,
          message: error.toString(),
        ),
      );
    }
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString("userId");
    return id ?? '';
  }
}
