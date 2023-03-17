import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lojaapp/features/login/domain/usecases/login_usecase.dart';
import 'package:lojaapp/features/login/presentation/controllers/login_event.dart';
import 'package:lojaapp/features/login/presentation/controllers/login_state.dart';
import 'package:lojaapp/main.dart';

class LoginBloc {
  LoginUseCase loginUseCase;

  late StreamController<LoginState> _state;
  Stream<LoginState> get state => _state.stream;

  late StreamController<LoginEvent> _event;
  Sink<LoginEvent> get event => _event.sink;

  LoginBloc(this.loginUseCase) {
    _state = StreamController.broadcast();
    _event = StreamController.broadcast();

    _event.stream.listen(_mapEventToState);
  }

  _mapEventToState(LoginEvent event) {
    if (event is LoginEventSignIn) {
      signIn(event.context, event.email, event.password);
    } else {}
  }

  onPressedNavigate(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(gConsts.registerScreen, (route) => false);
  }

  signIn(BuildContext context, String email, String password) async {
    final loginRequest = await loginUseCase.login(email, password);

    loginRequest.fold((l) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l.message)));
    }, (r) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(gConsts.homeScreen, (route) => false);
    });
  }
}
