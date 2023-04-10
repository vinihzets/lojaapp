import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/core/global/product_entity.dart';

abstract class GetNewsUseCase {
  Future<Either<Failure, List<ProductEntity>>> getNews();
}
