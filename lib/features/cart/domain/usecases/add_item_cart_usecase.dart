import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';

abstract class AddCartUseCase {
  Future<Either<Failure, List<CartProductsDto>>> call();
}
