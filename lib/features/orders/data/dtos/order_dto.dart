import 'package:lojaapp/features/orders/domain/entities/order_entity.dart';

class OrderDto extends OrderEntity {
  OrderDto(
    super.products,
    super.productsPrice,
    super.status,
    super.totalPrice,
    super.idOrder,
  );

  factory OrderDto.fromJson(Map<dynamic, dynamic> map) {
    return OrderDto(map['products'], map['productsPrice'], map['status'],
        map['totalPrice'], map['orderId']);
  }
}
