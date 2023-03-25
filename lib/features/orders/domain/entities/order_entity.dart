import 'package:lojaapp/features/orders/domain/entities/products_entity.dart';

class OrderEntity {
  List<ProductsEntity> products;
  num productsPrice;
  num status;
  num totalPrice;
  String orderId;

  OrderEntity(
    this.products,
    this.productsPrice,
    this.status,
    this.totalPrice,
    this.orderId,
  );
}
