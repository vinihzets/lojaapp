import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/core/services/auth/auth_service.dart';
import 'package:lojaapp/features/initialize/presentation/bloc/initialize_event.dart';
import 'package:lojaapp/main.dart';

class InitializeBloc {
  AuthService authService;

  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  late StreamController<InitializeEvent> _event;
  Sink<InitializeEvent> get event => _event.sink;

  InitializeBloc(this.authService) {
    _event = StreamController.broadcast();
    _state = StreamController.broadcast();

    _event.stream.listen(_mapListenEvent);
  }

  dispatchEvent(InitializeEvent event) {
    _event.add(event);
  }

  dispatchState(BlocState state) {
    _state.add(state);
  }

  _mapListenEvent(InitializeEvent event) {
    isLogged(event.context);
  }

  navigate(BuildContext context, String routeName) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }

  isLogged(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        dispatchState(
            BlocStableState(data: navigate(context, gConsts.homeScreen)));
      } else {
        dispatchState(
            BlocStableState(data: navigate(context, gConsts.loginScreen)));
      }
    });
  }
}
