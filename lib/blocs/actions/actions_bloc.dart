import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcase_app/blocs/actions/actions_event.dart';
import 'package:showcase_app/blocs/actions/actions_state.dart';
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
      final result = await actionsRepo.submitDetails(
        event.visitor,
      );
      emitter(state.copyWith(
          status: result ? ActionsStatus.success : ActionsStatus.error));
    } catch (e) {
      emitter(state.copyWith(
        status: ActionsStatus.error,
      ));
    }
  }
}