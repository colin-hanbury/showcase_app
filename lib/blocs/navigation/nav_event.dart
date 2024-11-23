import 'package:equatable/equatable.dart';

class NavEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PageChangedEvent extends NavEvent {
  final int index;
  PageChangedEvent({
    required this.index,
  });
  @override
  List<Object?> get props => [
        index,
      ];
}
