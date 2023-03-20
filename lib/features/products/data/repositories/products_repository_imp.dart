import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/features/products/data/datasources/products_datasource.dart';
import 'package:lojaapp/features/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImp implements ProductsRepository {
  ProductsDataSource productsDataSource;

  ProductsRepositoryImp(this.productsDataSource);

  @override
  Future<Either<Failure, dynamic>> getProducts(String uid) {
    return productsDataSource.getProducts(uid);
  }
}
