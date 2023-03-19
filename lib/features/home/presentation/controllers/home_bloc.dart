import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lojaapp/core/architeture/bloc.dart';
import 'package:lojaapp/core/architeture/bloc_event.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/home/domain/usecases/use_case.dart';
import 'package:lojaapp/main.dart';

import '../../domain/usecases/sign_out_usecase.dart';

class HomeBloc {
  SignOutUseCase signOutUseCase;

  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  late StreamController<BlocEvent> _event;
  Sink<BlocEvent> get event => _event.sink;

  HomeBloc(this.signOutUseCase) {
    _state = StreamController.broadcast();
    _event = StreamController.broadcast();

    _event.stream.listen(_dispatchEvent);
  }

  void _dispatchState(BlocState state) {
    _state.add(state);
  }

  _dispatchEvent(BlocEvent event) {
    if (event is BlocEventDrawerNavigateHome) {
      onPressedNavigate(event.context, event.routeName);
    } else if (event is BlocEventSignOutHome) {
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
