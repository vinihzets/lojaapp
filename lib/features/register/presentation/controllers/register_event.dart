import 'package:flutter/material.dart';

abstract class RegisterEvent {}

class RegisterEventLoading extends RegisterEvent {
  bool isLoading = true;

  RegisterEventLoading(this.isLoading);
}

class RegisterEventSignUp extends RegisterEvent {
  String email;
  String password;
  BuildContext context;

  RegisterEventSignUp(
      {required this.email, required this.password, required this.context});
}
