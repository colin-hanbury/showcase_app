import 'package:equatable/equatable.dart';
import 'package:showcase_app/models/user.dart';

enum ActionsStatus {
  initial,
  success,
  loading,
  error,
}

class ActionsState extends Equatable {
  final ActionsStatus status;
  final User user;

  ActionsState({
    this.status = ActionsStatus.initial,
    User? user,
  }) : user = user ?? User();

  @override
  List<Object?> get props => [
        status,
        user,
      ];

  ActionsState copyWith({
    ActionsStatus? status,
    User? user,
  }) =>
      ActionsState(
        status: status ?? this.status,
        user: user ?? this.user,
      );
}
