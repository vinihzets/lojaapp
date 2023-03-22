import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/cart/data/datasources/cart_datasources.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';
import 'package:lojaapp/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImp implements CartRepository {
  CartDataSource cartDataSource;

  CartRepositoryImp(this.cartDataSource);

  Future<Either<Failure, List<CartProductsDto>>> getCartItems() {
    return cartDataSource.getCartItems();
  }

  @override
  Future<Either<Failure, void>> removeCartItems(String id) {
    return cartDataSource.removeCartItems(id);
  }

  @override
  Future<Either<Failure, void>> decProduct(CartProductsDto cartProductsDto) {
    return cartDataSource.decProduct(cartProductsDto);
  }

  @override
  Future<Either<Failure, void>> incProduct(CartProductsDto cartProductsDto) {
    return cartDataSource.incProduct(cartProductsDto);
  }
}