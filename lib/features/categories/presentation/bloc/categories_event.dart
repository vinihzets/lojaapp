import 'package:flutter/material.dart';

class BlocCategoriesEvent {}

class BlocCategoriesEventGetCategories implements BlocCategoriesEvent {}

class BlocCategoriesEventNavigateToProductDetails
    implements BlocCategoriesEvent {
  BuildContext context;
  String routeName;
  Object arguments;

  BlocCategoriesEventNavigateToProductDetails(
      this.context, this.routeName, this.arguments);
}

class BlocCategoriesEventNavigate implements BlocCategoriesEvent {
  BuildContext context;
  String routeName;

  BlocCategoriesEventNavigate(this.context, this.routeName);
}
