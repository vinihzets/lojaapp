import 'package:lojaapp/features/products/data/dtos/products_dto.dart';

class CartProductsEntity {
  // String cartId;
  String description;
  String name;
  String price;
  String size;
  // int quantity;

  CartProductsEntity(
    // this.cartId,
    this.description,
    this.name,
    this.price,
    // this.quantity,
    this.size,
  );
}
