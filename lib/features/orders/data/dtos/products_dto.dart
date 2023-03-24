import 'package:lojaapp/features/orders/domain/entities/products_entity.dart';

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
      map['priceUnity'],
      map['quantity'],
      map['size'],
    );
  }
}
