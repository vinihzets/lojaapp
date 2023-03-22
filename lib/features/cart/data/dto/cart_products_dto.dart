import 'package:lojaapp/features/cart/domain/entities/cart_products_entity.dart';

class CartProductsDto extends CartProductsEntity {
  CartProductsDto(
    // super.cartId,
    super.description,
    super.name,
    super.price,
    // super.quantity,
    super.size,
  );

  factory CartProductsDto.fromJson(Map map) {
    return CartProductsDto(
      // map['cartId'],
      map['description'],
      map['name'],
      map['price'],
      // map['quantity'],
      map['size'],
    );
  }

  toMap() {
    return {
      // 'cartId': cartId,
      'description': description,
      'name': name,
      'price': price,
      // 'quantity': quantity,
      'size': size
    };
  }
}
