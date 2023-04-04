import 'package:lojaapp/features/cart/domain/entities/cart_products_entity.dart';

class CartProductsDto extends CartProductsEntity {
  CartProductsDto(
    super.description,
    super.name,
    super.images,
    super.price,
    super.size,
    super.quantity,
    super.id,
  );

  factory CartProductsDto.fromJson(Map map) {
    return CartProductsDto(
      map['description'],
      map['name'],
      map['images'],
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
      'price': price,
      'image': images.first,
      'size': size,
      'quantity': quantity,
      'id': id,
    };
  }

  toOrderMap() {
    return {
      'name': name,
      'price': price,
      'size': size,
      'quantity': quantity,
    };
  }
}
