import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ThemeChanged extends ThemeEvent {
  final ThemeMode mode;

  ThemeChanged({
    required this.mode,
  });

  @override
  List<Object?> get props => [mode];
}
