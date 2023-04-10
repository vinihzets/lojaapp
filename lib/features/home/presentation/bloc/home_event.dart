import 'package:flutter/material.dart';
import 'package:lojaapp/core/global/product_entity.dart';

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

class HomeEventGetNews implements HomeEvent {
  BuildContext context;

  HomeEventGetNews(this.context);
}

class HomeEventNavigateToDetails implements HomeEvent {
  BuildContext context;
  ProductEntity entity;

  HomeEventNavigateToDetails(this.context, this.entity);
}
