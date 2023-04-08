import 'products_dto.dart';
import '../../domain/entities/order_entity.dart';

class OrderDto extends OrderEntity {
  OrderDto(
    super.products,
    super.productsPrice,
    super.status,
    super.totalPrice,
    super.idOrder,
    super.discount,
  );

  factory OrderDto.fromJson(Map<dynamic, dynamic> map) {
    return OrderDto(
      (map['products'] as List).map((e) => ProductsDto.fromJson(e)).toList(),
      map['productsPrice'],
      map['status'],
      map['totalPrice'],
      map['orderId'],
      map['discount'],
    );
  }
}
