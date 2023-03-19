import 'dart:async';

import 'package:flutter/material.dart';

import 'bloc_state.dart';

abstract class BloC<Event> {
  late StreamController<BlocState> _state;
  Stream<BlocState> get bloc => _state.stream;

  late StreamController<Event> _event;
  Sink<Event> get event => _event.sink;

  BloC() {
    _state = StreamController.broadcast();
    _event = StreamController.broadcast();
  }

  void sendEvent(Event event) {
    handleEvent(event);
  }

  @protected
  void handleEvent(Event event);

  @protected
  void dispatchState(BlocState state) {
    _state.add(state);
  }
}
