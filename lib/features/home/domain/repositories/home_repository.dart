import 'package:dartz/dartz.dart';
import 'package:lojaapp/features/home/domain/entities/product_entity.dart';
import '../../../../core/failure/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, List<ProductEntity>>> getNews();
}
