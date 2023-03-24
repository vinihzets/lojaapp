import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/features/cart/domain/repositories/cart_repository.dart';
import 'package:lojaapp/features/cart/domain/usecases/discount_cart_items_usecase.dart';

class DiscountCardItemUseCaseImp implements DiscountCardItemUseCase {
  CartRepository cartRepository;

  DiscountCardItemUseCaseImp(this.cartRepository);

  @override
  Future<Either<Failure, DocumentSnapshot>> couponVerify(String coupon) {
    return cartRepository.discountCard(coupon);
  }
}
