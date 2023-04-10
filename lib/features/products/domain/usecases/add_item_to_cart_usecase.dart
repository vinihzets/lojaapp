import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/global/product_dto.dart';
import 'package:lojaapp/core/global/product_entity.dart';
import '../../../../core/failure/failure.dart';

abstract class AddItemToCartUseCase {
  Future<Either<Failure, dynamic>> call(ProductDto productsDto);
}
