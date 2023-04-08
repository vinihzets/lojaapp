import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../datasources/products_datasource.dart';
import '../dtos/products_dto.dart';
import '../../domain/entities/products_entity.dart';
import '../../domain/repositories/products_repository.dart';

class ProductsRepositoryImp implements ProductsRepository {
  ProductsDataSource productsDataSource;

  ProductsRepositoryImp(this.productsDataSource);

  @override
  Future<Either<Failure, List<ProductsEntity>>> getProducts(String uid) {
    return productsDataSource.getProducts(uid);
  }

  @override
  Future<Either<Failure, dynamic>> addItemToCart(ProductsDto productsDto) {
    return productsDataSource.addItemToCart(productsDto);
  }
}
