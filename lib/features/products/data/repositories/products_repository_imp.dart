import 'package:lojaapp/core/global/product_dto.dart';
import 'package:lojaapp/core/global/product_entity.dart';

import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../datasources/products_datasource.dart';

import '../../domain/repositories/products_repository.dart';

class ProductsRepositoryImp implements ProductsRepository {
  ProductsDataSource productsDataSource;

  ProductsRepositoryImp(this.productsDataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(String uid) {
    return productsDataSource.getProducts(uid);
  }

  @override
  Future<Either<Failure, dynamic>> addItemToCart(ProductDto productsDto) {
    return productsDataSource.addItemToCart(productsDto);
  }
}
