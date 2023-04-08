import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/architeture/bloc_state.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/services/auth/auth_service.dart';
import 'initialize_event.dart';
import '../../../../main.dart';

class NavigateMixin {
  navigate(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(
      routeName,
    );
  }
}

class InitializeBloc with NavigateMixin {
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
    if (event is InitializeEventIsLogged) {
      navigate(event.context, event.routeName);
    } else if (event is InitializeEventIsNotLogged) {
      navigate(event.context, event.routeName);
    }
  }

  isLogged(BuildContext context) async {
    try {
      if (authService.auth.currentUser != null) {
        dispatchEvent(InitializeEventIsLogged(context, gConsts.homeScreen));
      } else {
        dispatchEvent(InitializeEventIsNotLogged(context, gConsts.loginScreen));
      }
    } on FirebaseException catch (e) {
      RemoteFailure(message: e.message ?? '');
    }
  }
}
