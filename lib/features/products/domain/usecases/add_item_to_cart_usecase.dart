import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../data/dtos/products_dto.dart';

abstract class AddItemToCartUseCase {
  Future<Either<Failure, dynamic>> call(ProductsDto productsDto);
}
