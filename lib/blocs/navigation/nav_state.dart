import 'package:equatable/equatable.dart';

class NavState extends Equatable {
  final int pageIndex;

  NavState({
    int? pageIndex,
  }) : pageIndex = pageIndex ?? 0;
  @override
  List<Object?> get props => [
        pageIndex,
      ];

  NavState copyWith({
    int? pageIndex,
  }) =>
      NavState(
        pageIndex: pageIndex ?? this.pageIndex,
      );
}
