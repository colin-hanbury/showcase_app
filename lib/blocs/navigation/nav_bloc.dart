import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcase_app/blocs/navigation/nav_event.dart';
import 'package:showcase_app/blocs/navigation/nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavState()) {
    on<PageChangedEvent>(changeTab as EventHandler<PageChangedEvent, NavState>);
  }

  Future<void> changeTab(
      PageChangedEvent event, Emitter<NavState> emitter) async {
    emitter(
      state.copyWith(
        pageIndex: event.index,
      ),
    );
  }
}
