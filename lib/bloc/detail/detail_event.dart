import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable {}

class GetAll implements DetailEvent {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;

} 