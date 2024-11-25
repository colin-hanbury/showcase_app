import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcase_app/blocs/welcome/welcome_event.dart';
import 'package:showcase_app/blocs/welcome/welcome_state.dart';
import 'package:showcase_app/models/welcome.dart';
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
      final welcome = await welcomeRepo.getWelcomeMessage();
      emitter(
        state.copyWith(
          status: WelcomeStatus.success,
          welcome: welcome,
        ),
      );
    } catch (error) {
      emitter(
        state.copyWith(
          status: WelcomeStatus.error,
          welcome: Welcome(title: 'Error', message: error.toString()),
        ),
      );
    }
  }
}
