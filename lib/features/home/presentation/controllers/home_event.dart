import 'package:flutter/material.dart';

abstract class HomeEvent {}

class HomeEventDrawerNavigateToHome implements HomeEvent {
  BuildContext context;

  String routeName;

  HomeEventDrawerNavigateToHome(this.context, this.routeName);
}

class HomeEventDrawerNavigateToLocalization implements HomeEvent {
  BuildContext context;

  String routeName;

  HomeEventDrawerNavigateToLocalization(this.context, this.routeName);
}

class HomeEventDrawerNavigateToCategories implements HomeEvent {
  BuildContext context;

  String routeName;

  HomeEventDrawerNavigateToCategories(this.context, this.routeName);
}

class HomeEventDrawerNavigateToMyCart implements HomeEvent {
  BuildContext context;

  String routeName;

  HomeEventDrawerNavigateToMyCart(this.context, this.routeName);
}

class HomeEventSignOut implements HomeEvent {
  BuildContext context;

  HomeEventSignOut(this.context);
}
