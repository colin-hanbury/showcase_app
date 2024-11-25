import 'package:equatable/equatable.dart';
import 'package:showcase_app/models/welcome.dart';

enum WelcomeStatus {
  initial,
  success,
  loading,
  error,
}

class WelcomeState extends Equatable {
  final Welcome welcome;
  final WelcomeStatus status;

  WelcomeState({
    this.status = WelcomeStatus.initial,
    Welcome? welcome,
  }) : welcome = welcome ?? Welcome(title: null, message: null);

  @override
  List<Object?> get props => [
        status,
        welcome,
      ];

  WelcomeState copyWith({
    WelcomeStatus? status,
    Welcome? welcome,
  }) =>
      WelcomeState(
        status: status ?? this.status,
        welcome: welcome ?? this.welcome,
      );
}
