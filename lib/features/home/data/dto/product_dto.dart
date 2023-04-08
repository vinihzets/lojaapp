import 'package:lojaapp/features/home/domain/entities/product_entity.dart';

class ProductDto extends ProductEntity {
  ProductDto(
    super.categoryId,
    super.createdAt,
    super.description,
    super.images,
    super.name,
    super.price,
    super.productId,
    super.sizes,
  );

  factory ProductDto.fromJson(Map map) {
    return ProductDto(
      map['categoryId'],
      map['createdAt'],
      map['description'],
      map['images'],
      map['name'],
      map['price'],
      map['productId'],
      map['sizes'],
    );
  }
}
