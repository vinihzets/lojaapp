import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../dtos/products_dto.dart';
import '../../domain/entities/products_entity.dart';

abstract class ProductsDataSource {
  Future<Either<Failure, List<ProductsEntity>>> getProducts(String uid);
  Future<Either<Failure, dynamic>> addItemToCart(ProductsDto productsDto);
}
