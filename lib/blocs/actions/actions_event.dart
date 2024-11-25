import 'package:equatable/equatable.dart';
import 'package:showcase_app/models/visitor.dart';

class ActionsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitDetails extends ActionsEvent {
  final Visitor visitor;

  SubmitDetails({
    required this.visitor,
  });

  @override
  List<Object> get props => [visitor];
}
