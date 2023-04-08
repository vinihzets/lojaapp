import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../data/dto/cart_products_dto.dart';

abstract class DecProductUseCase {
  Future<Either<Failure, void>> decProduct(CartProductsDto cartProductsDto);
}
