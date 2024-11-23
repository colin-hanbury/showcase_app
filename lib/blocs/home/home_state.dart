import 'package:equatable/equatable.dart';
import 'package:showcase_app/models/welcome.dart';

enum HomeStatus {
  initial,
  success,
  loading,
  error,
}

class HomeState extends Equatable {
  final Welcome welcome;
  final HomeStatus status;

  HomeState({
    this.status = HomeStatus.initial,
    Welcome? welcome,
  }) : welcome = welcome ?? Welcome(title: '', message: '');

  @override
  List<Object?> get props => [
        status,
        welcome,
      ];

  HomeState copyWith({
    HomeStatus? status,
    Welcome? welcome,
  }) =>
      HomeState(
        status: status ?? this.status,
        welcome: welcome ?? this.welcome,
      );
}
