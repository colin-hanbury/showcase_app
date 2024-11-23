import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcase_app/blocs/home/home_event.dart';
import 'package:showcase_app/blocs/home/home_state.dart';
import 'package:showcase_app/models/welcome.dart';
import 'package:showcase_app/repos/welcome_repo.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.welcomeRepo}) : super(HomeState()) {
    on<GetWelcomeMessage>(getWelcomeMessage);
  }

  final WelcomeRepo welcomeRepo;

  Future<void> getWelcomeMessage(
      GetWelcomeMessage event, Emitter<HomeState> emitter) async {
    emitter(state.copyWith(status: HomeStatus.loading));
    try {
      final welcome = await welcomeRepo.getWelcomeMessage();
      emitter(
        state.copyWith(
          status: HomeStatus.success,
          welcome: welcome,
        ),
      );
    } catch (error) {
      emitter(
        state.copyWith(
          status: HomeStatus.error,
          welcome: Welcome(title: 'Error', message: error.toString()),
        ),
      );
    }
  }
}
