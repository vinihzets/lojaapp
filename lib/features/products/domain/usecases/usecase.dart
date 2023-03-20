import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/products/domain/entities/products_entity.dart';

abstract class UseCase {
  Future<Either<Failure, List<ProductsEntity>>> call(String uid);
}
