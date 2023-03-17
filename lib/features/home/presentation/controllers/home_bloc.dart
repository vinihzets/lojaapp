import 'dart:async';

import 'package:lojaapp/features/home/presentation/controllers/home_event.dart';
import 'package:lojaapp/features/home/presentation/controllers/home_state.dart';

class HomeBloc {
  late StreamController<HomeState> _state;
  Stream<HomeState> get state => _state.stream;

  late StreamController<HomeEvent> _event;
  Sink<HomeEvent> get event => _event.sink;

  HomeBloc() {
    _state = StreamController.broadcast();
    _event = StreamController.broadcast();
  }
}
