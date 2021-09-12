import 'package:equatable/equatable.dart';
import 'package:vidbol_app/models/footbal_data.dart';

abstract class HomeState extends Equatable {}

class Initial implements HomeState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class Loading implements HomeState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class DataLoaded implements HomeState {
  final List<FootballData> footballData;

  const DataLoaded(this.footballData);

  @override
  List<Object?> get props => [footballData];

  @override
  bool? get stringify => true;
}

class ShowMessage implements HomeState {
  final String message;

  const ShowMessage(this.message);

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => false;

}
