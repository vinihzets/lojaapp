import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lojaapp/features/home/domain/usecases/sign_out_usecase.dart';
import 'package:lojaapp/features/home/presentation/controllers/home_event.dart';
import 'package:lojaapp/features/home/presentation/controllers/home_state.dart';
import 'package:lojaapp/main.dart';

class HomeBloc {
  SignOutUseCase signOutUseCase;

  late StreamController<HomeState> _state;
  Stream<HomeState> get state => _state.stream;

  late StreamController<HomeEvent> _event;
  Sink<HomeEvent> get event => _event.sink;

  HomeBloc(this.signOutUseCase) {
    _state = StreamController.broadcast();
    _event = StreamController.broadcast();

    _event.stream.listen(_eventSendState);
  }

  _eventSendState(HomeEvent event) {
    if (event is HomeEventDrawerNavigateToHome) {
      onPressedNavigate(event.context, event.routeName);
    } else if (event is HomeEventDrawerNavigateToCategories) {
      onPressedNavigate(event.context, event.routeName);
    } else if (event is HomeEventDrawerNavigateToLocalization) {
      onPressedNavigate(event.context, event.routeName);
    } else if (event is HomeEventDrawerNavigateToMyCart) {
      onPressedNavigate(event.context, event.routeName);
    } else if (event is HomeEventSignOut) {
      signOut(event.context);
    }
  }

  signOut(BuildContext context) async {
    final requestSignOut = await signOutUseCase.signOut();

    requestSignOut.fold((l) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l.message)));
    }, (r) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(gConsts.loginScreen, (route) => false);
    });
  }

  onPressedNavigate(BuildContext context, String name) {
    Navigator.of(context).pushNamed(name);
  }
}
