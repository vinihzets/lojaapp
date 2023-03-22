import 'package:lojaapp/features/products/data/dtos/products_dto.dart';

class CartProductsEntity {
  String description;
  String name;
  String imageUrl;
  String price;
  String size;
  int quantity;
  String id;

  CartProductsEntity(this.description, this.name, this.imageUrl, this.price,
      this.size, this.quantity, this.id);
}
