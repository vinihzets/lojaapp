import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';
import 'package:lojaapp/features/cart/domain/repositories/cart_repository.dart';
import 'package:lojaapp/features/cart/domain/usecases/add_cart_order_usecase.dart';

class AddCartOrderUseCaseImp implements AddCartOrderUseCase {
  CartRepository cartRepository;

  AddCartOrderUseCaseImp(this.cartRepository);
  @override
  Future<Either<Failure, DocumentReference>> addOrder(
    List<CartProductsDto> cartProductsDto,
    double productsPrice,
    double discount,
    double totalPrice,
  ) {
    return cartRepository.addOrder(
        cartProductsDto, productsPrice, discount, totalPrice);
  }
}
