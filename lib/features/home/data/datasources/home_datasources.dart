import 'package:dartz/dartz.dart';
import 'package:lojaapp/features/home/data/dto/product_dto.dart';
import '../../../../core/failure/failure.dart';

abstract class HomeDataSource {
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, List<ProductDto>>> getNews();
}
