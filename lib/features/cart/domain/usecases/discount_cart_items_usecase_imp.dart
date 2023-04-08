import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../repositories/cart_repository.dart';
import 'discount_cart_items_usecase.dart';

class DiscountCardItemUseCaseImp implements DiscountCardItemUseCase {
  CartRepository cartRepository;

  DiscountCardItemUseCaseImp(this.cartRepository);

  @override
  Future<Either<Failure, DocumentSnapshot>> couponVerify(String coupon) {
    return cartRepository.discountCard(coupon);
  }
}
