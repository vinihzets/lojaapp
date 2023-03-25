abstract class ProductsEntity {
  String description;
  String image;
  String name;
  String priceUnity;
  int quantity;
  String size;

  ProductsEntity(
    this.description,
    this.image,
    this.name,
    this.priceUnity,
    this.quantity,
    this.size,
  );
}
