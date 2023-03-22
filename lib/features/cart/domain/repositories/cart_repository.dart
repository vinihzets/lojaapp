import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartProductsDto>>> getCartItems();
  Future<Either<Failure, void>> removeCartItems(String id);
  Future<Either<Failure, void>> decProduct(CartProductsDto cartProductsDto);
  Future<Either<Failure, void>> incProduct(CartProductsDto cartProductsDto);
  Future<Either<Failure, DocumentSnapshot>> discountCard(String counpon);
  Future<Either<Failure, dynamic>> getPrice(CartProductsDto cartProductsDto);
}
