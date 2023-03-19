import 'package:flutter/widgets.dart';
import 'package:lojaapp/features/categories/domain/entities/categories_entity.dart';

class BlocEvent {}

class BlocEventDrawerNavigateHome implements BlocEvent {
  BuildContext context;
  String routeName;

  BlocEventDrawerNavigateHome(this.context, this.routeName);
}

class BlocEventSignOutHome implements BlocEvent {
  BuildContext context;

  BlocEventSignOutHome(this.context);
}

class BlocEventGetCategories implements BlocEvent {
  // List<CategoriesEntity> querySnapshot;
  // BuildContext context;

  // BlocEventGetCategories(this.context, this.querySnapshot);
}
