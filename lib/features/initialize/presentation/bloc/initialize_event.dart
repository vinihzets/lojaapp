import 'package:flutter/material.dart';

class InitializeEvent {}

class InitializeEventIsLogged implements InitializeEvent {
  BuildContext context;
  String routeName;

  InitializeEventIsLogged(this.context, this.routeName);
}

class InitializeEventIsNotLogged implements InitializeEvent {
  BuildContext context;
  String routeName;

  InitializeEventIsNotLogged(this.context, this.routeName);
}
