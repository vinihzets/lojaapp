import 'package:flutter/material.dart';

abstract class HomeEvent {}

class HomeEventDrawerNavigate implements HomeEvent {
  BuildContext context;
  String routeName;

  HomeEventDrawerNavigate(this.context, this.routeName);
}

class HomeEventSignOut implements HomeEvent {
  BuildContext context;

  HomeEventSignOut(this.context);
}

class HomeEventGetCategories implements HomeEvent {}
