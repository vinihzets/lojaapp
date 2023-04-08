import 'dart:async';
import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../../data/dto/cart_products_dto.dart';
import '../repositories/cart_repository.dart';
import 'get_cart_item_usecase.dart';

class AddCartUseCaseImp implements GetItemsCart {
  CartRepository cartRepository;

  AddCartUseCaseImp(this.cartRepository);
  @override
  Future<Either<Failure, List<CartProductsDto>>> call() {
    return cartRepository.getCartItems();
  }
}
