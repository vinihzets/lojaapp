import 'package:flutter/material.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';

abstract class CartEvent {}

class CartEventAddItem implements CartEvent {
  BuildContext context;

  CartEventAddItem(this.context);
}
