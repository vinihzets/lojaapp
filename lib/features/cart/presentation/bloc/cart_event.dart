import 'package:flutter/material.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';

abstract class CartEvent {}

class CartEventAddItem implements CartEvent {
  BuildContext context;

  CartEventAddItem(this.context);
}

class CartEventRemoveItem implements CartEvent {
  BuildContext context;
  String id;

  CartEventRemoveItem(this.context, this.id);
}

class CartEventIncItem implements CartEvent {
  BuildContext context;
  CartProductsDto cartProductsDto;

  CartEventIncItem(this.context, this.cartProductsDto);
}

class CartEventDecItem implements CartEvent {
  BuildContext context;
  CartProductsDto cartProductsDto;

  CartEventDecItem(this.context, this.cartProductsDto);
}
