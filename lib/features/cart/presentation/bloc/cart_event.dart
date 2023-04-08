import 'package:flutter/material.dart';

import '../../data/dto/cart_products_dto.dart';

abstract class CartEvent {}

class CartEventGetItemsCart implements CartEvent {
  BuildContext context;

  CartEventGetItemsCart(
    this.context,
  );
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

class CartEventNavigate implements CartEvent {
  BuildContext context;
  String routeName;

  CartEventNavigate(this.context, this.routeName);
}

class CartEventCouponVerify implements CartEvent {
  BuildContext context;
  String coupon;
  double totalValue;

  CartEventCouponVerify(this.context, this.coupon, this.totalValue);
}

class CartEventCouponExists implements CartEvent {
  num percent;
  double totalValue;
  bool applyCupom;

  CartEventCouponExists(this.totalValue, this.percent, this.applyCupom);
}

class CartEventCreateOrder implements CartEvent {
  BuildContext context;
  double productsPrice;
  double discount;
  double totalPrice;

  CartEventCreateOrder(
      this.context, this.productsPrice, this.discount, this.totalPrice);
}
