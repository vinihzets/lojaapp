import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/products/data/dtos/products_dto.dart';

abstract class AddItemToCartUseCase {
  Future<Either<Failure, dynamic>> call(ProductsDto productsDto);
}
