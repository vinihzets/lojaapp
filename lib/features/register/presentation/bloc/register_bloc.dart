import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/usecases/register_usecase.dart';
import 'register_event.dart';
import 'register_state.dart';
import '../../../../main.dart';

class RegisterBloC {
  RegisterUseCase registerUseCase;

  late StreamController<RegisterState> _state;
  Stream<RegisterState> get state => _state.stream;

  late StreamController<RegisterEvent> _event;
  Sink<RegisterEvent> get event => _event.sink;

  RegisterBloC({required this.registerUseCase}) {
    _event = StreamController.broadcast();
    _state = StreamController.broadcast();

    _event.stream.listen(_mapEventToState);
  }

  onPressedRegister(String email, String password, BuildContext context) async {
    final registerRequest = await registerUseCase.register(
      email,
      password,
    );
    registerRequest.fold((l) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l.message)));
    }, (r) {
      Navigator.pushNamed(context, gConsts.loginScreen);
    });
  }

  _mapEventToState(RegisterEvent event) {
    if (event is RegisterEventSignUp) {
      onPressedRegister(event.email, event.password, event.context);
    }
  }

  onNavigatePop(BuildContext context) {
    Navigator.pop(context);
  }
}
