import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/home/domain/entities/product_entity.dart';

abstract class GetNewsUseCase {
  Future<Either<Failure, List<ProductEntity>>> getNews();
}
