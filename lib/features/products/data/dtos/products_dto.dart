import 'package:lojaapp/features/products/domain/entities/products_entity.dart';

class ProductsDto extends ProductsEntity {
  ProductsDto(super.name, super.sizes, super.description);

  factory ProductsDto.fromJson(Map map) {
    return ProductsDto(map['name'], map['sizes'], map['description']);
  }
}
