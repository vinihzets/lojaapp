class ProductsEntity {
  String name;
  List sizes;
  List images;
  String price;
  String description;
  String? sizeProduct;
  // String? cartId;
  // int quantity;

  ProductsEntity(
    this.name,
    this.sizes,
    this.images,
    this.price,
    this.description,
    this.sizeProduct,
    // this.quantity,
  );
}
