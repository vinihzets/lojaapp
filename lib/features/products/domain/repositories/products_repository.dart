import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/global/product_dto.dart';
import 'package:lojaapp/core/global/product_entity.dart';
import '../../../../core/failure/failure.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts(String uid);
  Future<Either<Failure, dynamic>> addItemToCart(ProductDto productsDto);
}
