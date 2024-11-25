import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ThemeStatus {
  initial,
  successful,
  loading,
  error,
}

class ThemeState extends Equatable {
  final ThemeStatus status;
  final ThemeMode mode;
  ThemeState({
    this.status = ThemeStatus.initial,
    mode,
  }) : mode = mode ?? ThemeMode.light;

  @override
  List<Object?> get props => [status, mode];

  ThemeState copyWith({ThemeStatus? status, ThemeMode? mode}) =>
      ThemeState(status: status ?? this.status, mode: mode ?? this.mode);
}
