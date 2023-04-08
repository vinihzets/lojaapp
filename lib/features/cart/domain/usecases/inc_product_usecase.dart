import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../data/dto/cart_products_dto.dart';

abstract class IncProductUseCase {
  Future<Either<Failure, void>> incProduct(CartProductsDto cartProductsDto);
}
