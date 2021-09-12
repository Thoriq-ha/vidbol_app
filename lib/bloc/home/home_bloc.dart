import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidbol_app/bloc/home/home_event.dart';
import 'package:vidbol_app/bloc/home/home_state.dart';
import 'package:vidbol_app/models/footbal_data.dart';
import 'package:vidbol_app/repository/data_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DataRepository dataRepository;

  HomeBloc(this.dataRepository) : super(Initial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetAll) {
      yield* _getAllData();
    }
  }

  Stream<HomeState> _getAllData() async* {
    try {
      yield Loading();
      List<FootballData> footballData = await dataRepository.fetchData();
      yield DataLoaded(footballData);
    } catch (e) {
      print(e);
      ShowMessage(e.toString());
    }
  }
}
