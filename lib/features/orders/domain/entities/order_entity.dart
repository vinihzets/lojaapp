class OrderEntity {
  List products;
  num productsPrice;
  num status;
  num totalPrice;
  String orderId;

  OrderEntity(this.products, this.productsPrice, this.status, this.totalPrice,
      this.orderId);
}
