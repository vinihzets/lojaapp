import 'package:flutter/material.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';

class CartTileWidget extends StatelessWidget {
  CartProductsDto product;

  CartTileWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Text(product.name),
    );
  }
}
