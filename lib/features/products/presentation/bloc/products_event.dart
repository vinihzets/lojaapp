import 'package:flutter/material.dart';

abstract class ProductsEvent {}

class ProductsEventGet implements ProductsEvent {
  BuildContext context;
  String uid;

  ProductsEventGet(this.context, this.uid);
}
