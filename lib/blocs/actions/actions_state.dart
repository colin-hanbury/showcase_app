import 'package:equatable/equatable.dart';

enum ActionsStatus {
  initial,
  success,
  loading,
  error,
}

class ActionsState extends Equatable {
  final ActionsStatus status;

  ActionsState({
    this.status = ActionsStatus.initial,
  });

  @override
  List<Object?> get props => [
        status,
      ];

  ActionsState copyWith({
    ActionsStatus? status,
  }) =>
      ActionsState(
        status: status ?? this.status,
      );
}
