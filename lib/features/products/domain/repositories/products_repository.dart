import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';

abstract class ProductsRepository {
  Future<Either<Failure, dynamic>> getProducts(String uid);
}
