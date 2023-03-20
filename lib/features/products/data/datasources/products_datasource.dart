import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';

abstract class ProductsDataSource {
  Future<Either<Failure, dynamic>> getProducts(String uid);
}
