import 'package:flutter/material.dart';
import 'package:lojaapp/features/products/domain/entities/products_entity.dart';

abstract class ProductsEvent {}

class ProductsEventGet implements ProductsEvent {
  BuildContext context;
  String uid;

  ProductsEventGet(this.context, this.uid);
}

class ProductsEventNavigateDetails implements ProductsEvent {
  BuildContext context;
  ProductsEntity entity;

  ProductsEventNavigateDetails(this.context, this.entity);
}
