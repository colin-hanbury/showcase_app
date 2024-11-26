import 'package:equatable/equatable.dart';

enum WelcomeStatus {
  initial,
  success,
  loading,
  error,
}

class WelcomeState extends Equatable {
  final String message;
  final WelcomeStatus status;

  WelcomeState({
    this.status = WelcomeStatus.initial,
    String? message,
  }) : message = message ?? 'Welcome';

  @override
  List<Object?> get props => [
        status,
        message,
      ];

  WelcomeState copyWith({
    WelcomeStatus? status,
    String? message,
  }) =>
      WelcomeState(
        status: status ?? this.status,
        message: message ?? this.message,
      );
}
