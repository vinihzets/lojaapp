import 'package:lojaapp/features/products/domain/entities/products_entity.dart';

class ProductsDto extends ProductsEntity {
  ProductsDto(
    super.name,
    super.sizes,
    super.images,
    super.price,
    super.description,
    super.imageUrl,
    super.sizeProduct,
    // super.quantity,
  );

  factory ProductsDto.fromJson(Map map) {
    return ProductsDto(
      map['name'],
      map['sizes'],
      map['images'],
      map['price'],
      map['description'],
      map['image'],
      map['sizeProduct'],
      // map['quantity'],
    );
  }

  Map<String, dynamic> toResumedMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'size': sizeProduct,
      'image': imageUrl,
    };
  }
}
