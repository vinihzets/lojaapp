import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';
import 'package:lojaapp/features/cart/domain/repositories/cart_repository.dart';
import 'package:lojaapp/features/cart/domain/usecases/add_cart_usecase.dart';

class AddCartUseCaseImp implements AddCartUseCase {
  CartRepository cartRepository;

  AddCartUseCaseImp(this.cartRepository);
  @override
  Future<Either<Failure, List<CartProductsDto>>> call() {
    return cartRepository.getCartItems();
  }
}
