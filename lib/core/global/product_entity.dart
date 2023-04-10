import 'package:cloud_firestore/cloud_firestore.dart';

class ProductEntity {
  String name;
  List sizes;
  List images;
  String price;
  String description;
  String? sizeProduct;
  String id;
  String idCategory;
  Timestamp createdAt;

  // String? cartId;
  // int quantity;

  ProductEntity(
    this.name,
    this.sizes,
    this.images,
    this.price,
    this.description,
    this.sizeProduct,
    this.id,
    this.idCategory,
    this.createdAt,
    // this.quantity,
  );
}
