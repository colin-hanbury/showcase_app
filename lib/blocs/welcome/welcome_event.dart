import 'package:equatable/equatable.dart';

class WelcomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetWelcomeMessage extends WelcomeEvent {
  final String id;

  GetWelcomeMessage({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
