import 'dart:async';

import 'package:flutter/material.dart';

import 'bloc_state.dart';

mixin HudMixin {
  BuildContext get context => context;

  void showSnackBar(String message, {Color backgroundColor = Colors.black}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // void showSuccess(String message) {
  //   showSnackBar(message, backgroundColor: Colors.green);
  // }

  // void showFailure(String message) {
  //   showSnackBar(message, backgroundColor: Colors.red);
  // }
}

mixin NavigatorMixin {}

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
