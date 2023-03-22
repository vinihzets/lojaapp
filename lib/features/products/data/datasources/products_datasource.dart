import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/products/data/dtos/products_dto.dart';
import 'package:lojaapp/features/products/domain/entities/products_entity.dart';

abstract class ProductsDataSource {
  Future<Either<Failure, List<ProductsEntity>>> getProducts(String uid);
  Future<Either<Failure, dynamic>> addItemToCart(ProductsDto productsDto);
}
