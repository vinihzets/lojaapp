import 'products_entity.dart';

class OrderEntity {
  List<ProductsEntity> products;
  num productsPrice;
  num status;
  num totalPrice;
  String orderId;
  num discount;

  OrderEntity(this.products, this.productsPrice, this.status, this.totalPrice,
      this.orderId, this.discount);
}
