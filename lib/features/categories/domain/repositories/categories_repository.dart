import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/categories_entity.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<CategoriesEntity>>> call();
}
