import 'dart:async';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';
import 'package:lojaapp/features/cart/domain/repositories/cart_repository.dart';
import 'package:lojaapp/features/cart/domain/usecases/get_cart_item_usecase.dart';

class AddCartUseCaseImp implements GetItemsCart {
  CartRepository cartRepository;

  AddCartUseCaseImp(this.cartRepository);
  @override
  Future<Either<Failure, List<CartProductsDto>>> call() {
    return cartRepository.getCartItems();
  }
}
