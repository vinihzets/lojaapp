import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../data/dtos/products_dto.dart';
import '../entities/products_entity.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductsEntity>>> getProducts(String uid);
  Future<Either<Failure, dynamic>> addItemToCart(ProductsDto productsDto);
}
