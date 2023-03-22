import 'package:lojaapp/features/cart/domain/entities/cart_products_entity.dart';

class CartProductsDto extends CartProductsEntity {
  CartProductsDto(
    super.description,
    super.name,
    super.imageUrl,
    super.price,
    super.size,
    super.quantity,
    super.id,
  );

  factory CartProductsDto.fromJson(Map map) {
    return CartProductsDto(
      map['description'],
      map['name'],
      map['image'],
      map['price'],
      map['size'],
      map['quantity'],
      map['id'],
    );
  }

  toMap() {
    return {
      'description': description,
      'name': name,
      'image': imageUrl,
      'price': price,
      'size': size,
      'quantity': quantity,
      'id': id,
    };
  }
}
