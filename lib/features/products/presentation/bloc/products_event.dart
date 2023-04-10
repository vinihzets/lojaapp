import 'package:flutter/material.dart';
import 'package:lojaapp/core/global/product_dto.dart';
import 'package:lojaapp/core/global/product_entity.dart';

abstract class ProductsEvent {}

class ProductsEventGet implements ProductsEvent {
  BuildContext context;
  String uid;

  ProductsEventGet(this.context, this.uid);
}

class ProductsEventNavigateDetails implements ProductsEvent {
  BuildContext context;
  ProductEntity entity;

  ProductsEventNavigateDetails(this.context, this.entity);
}

class ProductsEventAddToCart implements ProductsEvent {
  BuildContext context;
  ProductDto productsDto;

  ProductsEventAddToCart(this.context, this.productsDto);
}
