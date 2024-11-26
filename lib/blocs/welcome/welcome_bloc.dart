import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcase_app/blocs/welcome/welcome_event.dart';
import 'package:showcase_app/blocs/welcome/welcome_state.dart';
import 'package:showcase_app/repos/welcome_repo.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc({required this.welcomeRepo}) : super(WelcomeState()) {
    on<GetWelcomeMessage>(
        getWelcomeMessage as EventHandler<GetWelcomeMessage, WelcomeState>);
  }

  final WelcomeRepo welcomeRepo;

  Future<void> getWelcomeMessage(
      GetWelcomeMessage event, Emitter<WelcomeState> emitter) async {
    emitter(state.copyWith(status: WelcomeStatus.loading));
    try {
      final message = await welcomeRepo.getWelcomeMessage(event.id);
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
}
