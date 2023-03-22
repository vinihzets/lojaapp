import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';

abstract class DecProductUseCase {
  Future<Either<Failure, void>> decProduct(CartProductsDto cartProductsDto);
}
