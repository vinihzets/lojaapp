import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/home/domain/usecases/use_case.dart';
import 'package:lojaapp/features/home/presentation/controllers/home_event.dart';
import 'package:lojaapp/main.dart';

import '../../domain/usecases/sign_out_usecase.dart';

class HomeBloc {
  SignOutUseCase signOutUseCase;

  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  late StreamController<HomeEvent> _event;
  Sink<HomeEvent> get event => _event.sink;

  HomeBloc(this.signOutUseCase) {
    _state = StreamController.broadcast();
    _event = StreamController.broadcast();

    _event.stream.listen(_dispatchEvent);
  }

  _dispatchEvent(HomeEvent event) {
    if (event is HomeEventDrawerNavigate) {
      onPressedNavigate(event.context, event.routeName);
    } else if (event is HomeEventSignOut) {
      signOut(event.context);
    }
  }

  signOut(BuildContext context) async {
    final requestSignOut = await signOutUseCase(params: NoParams());

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
