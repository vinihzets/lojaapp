import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';

abstract class CartDataSource {
  Future<Either<Failure, List<CartProductsDto>>> getCartItems();
}
