import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidbol_app/bloc/detail/detail_event.dart';
import 'package:vidbol_app/bloc/detail/detail_state.dart';
import 'package:vidbol_app/models/footbal_data.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final FootballData data;

  DetailBloc(this.data) : super(Initial());

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is GetAll) {
      yield* _getAllData();
    }
  }

  Stream<DetailState> _getAllData() async* {
    try {
      yield Loading();
      FootballData footballData = data;
      yield DataLoaded(footballData);
      print('assssssssssss ${footballData.title}');
    } catch (e) {
      print(e);
      ShowMessage(e.toString());
    }
  }
}
