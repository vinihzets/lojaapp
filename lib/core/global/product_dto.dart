import 'package:lojaapp/core/global/product_entity.dart';

class ProductDto extends ProductEntity {
  ProductDto(
    super.name,
    super.sizes,
    super.images,
    super.price,
    super.description,
    super.sizeProduct,
    super.id,
    super.idCategory,
    super.createdAt,
  );

  factory ProductDto.fromJson(Map map) {
    return ProductDto(
      map['name'],
      map['sizes'],
      map['images'],
      map['price'],
      map['description'],
      map['sizeProduct'],
      map['id'],
      map['idCategory'],
      map['createdAt'],
    );
  }

  Map<String, dynamic> toResumedMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'size': sizeProduct,
      'images': images,
    };
  }
}
