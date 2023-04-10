import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/global/product_entity.dart';
import '../../../../core/failure/failure.dart';

abstract class UseCase {
  Future<Either<Failure, List<ProductEntity>>> call(String uid);
}
