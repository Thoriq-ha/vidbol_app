import 'package:equatable/equatable.dart';
import 'package:vidbol_app/models/footbal_data.dart';

abstract class DetailState extends Equatable {}

class Initial implements DetailState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class Loading implements DetailState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class DataLoaded implements DetailState {
  final FootballData football;

  const DataLoaded(this.football);

  @override
  List<Object?> get props => [football];

  @override
  bool? get stringify => true;
}

class ShowMessage implements DetailState {
  final String message;

  const ShowMessage(this.message);

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => false;
}
