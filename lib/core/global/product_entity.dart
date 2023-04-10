import 'package:cloud_firestore/cloud_firestore.dart';

class ProductEntity {
  String name;
  List sizes;
  List images;
  String price;
  String description;
  String? sizeProduct;
  String productId;
  String idCategory;
  Timestamp createdAt;

  ProductEntity(
    this.name,
    this.sizes,
    this.images,
    this.price,
    this.description,
    this.sizeProduct,
    this.productId,
    this.idCategory,
    this.createdAt,
  );
}
