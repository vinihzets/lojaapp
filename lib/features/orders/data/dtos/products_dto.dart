import '../../domain/entities/products_entity.dart';

class ProductsDto extends ProductsEntity {
  ProductsDto(
    super.description,
    super.image,
    super.name,
    super.priceUnity,
    super.quantity,
    super.size,
  );

  factory ProductsDto.fromJson(Map map) {
    return ProductsDto(
      map['description'],
      map['image'],
      map['name'],
      map['price'],
      map['quantity'],
      map['size'],
    );
  }

  toMap() {
    return {
      'description': description,
      'image': image,
      'name': name,
      'price': priceUnity,
      'quantity': quantity,
      'size': size,
    };
  }

  toMapApi() {
    return {
      'title': name,
      'description': description,
      'picture_url': image,
      'quantity': quantity,
      'currency_id': 'BRL',
      'unity_price': priceUnity,
    };
  }
}
