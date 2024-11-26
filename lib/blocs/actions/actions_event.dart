import 'package:equatable/equatable.dart';
import 'package:showcase_app/models/user.dart';

class ActionsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitDetails extends ActionsEvent {
  final User user;

  SubmitDetails({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
