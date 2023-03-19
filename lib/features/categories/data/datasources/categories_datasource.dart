import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/categories/domain/entities/categories_entity.dart';

abstract class CategoriesDataSource {
  Future<Either<Failure, List<CategoriesEntity>>> call();
}
