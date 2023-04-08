import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/products_entity.dart';

abstract class UseCase {
  Future<Either<Failure, List<ProductsEntity>>> call(String uid);
}
