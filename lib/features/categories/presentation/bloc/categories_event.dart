import 'package:flutter/material.dart';

class BlocCategoriesEvent {}

class BlocCategoriesEventGetCategories implements BlocCategoriesEvent {}

class BlocCategoriesEventNavigateToCategorie implements BlocCategoriesEvent {
  BuildContext context;
  String routeName;

  BlocCategoriesEventNavigateToCategorie(this.context, this.routeName);
}
