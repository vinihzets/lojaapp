import 'package:cloud_firestore/cloud_firestore.dart';

class ProductEntity {
  String categoryId;
  Timestamp createdAt;
  String description;
  List images;
  String name;
  String price;
  String productId;
  List sizes;

  ProductEntity(
    this.categoryId,
    this.createdAt,
    this.description,
    this.images,
    this.name,
    this.price,
    this.productId,
    this.sizes,
  );
}
