import 'package:lojaapp/features/products/domain/entities/products_entity.dart';

class ProductsDto extends ProductsEntity {
  ProductsDto(super.name, super.sizes, super.images, super.price,
      super.description, super.imageUrl);

  factory ProductsDto.fromJson(Map map) {
    return ProductsDto(map['name'], map['sizes'], map['images'], map['price'],
        map['description'], map['image']);
  }
}
