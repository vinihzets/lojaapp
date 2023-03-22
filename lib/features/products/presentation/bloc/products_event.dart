import 'package:flutter/material.dart';
import 'package:lojaapp/features/products/data/dtos/products_dto.dart';
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

class ProductsEventAddToCart implements ProductsEvent {
  BuildContext context;
  ProductsDto productsDto;

  ProductsEventAddToCart(this.context, this.productsDto);
}
