import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';

abstract class GetAllProductsPriceUseCase {
  Future<Either<Failure, dynamic>> getPrice(CartProductsDto cartProductsDto);
}
