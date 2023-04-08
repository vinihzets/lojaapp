import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entities/categories_entity.dart';

abstract class CategoriesDataSource {
  Future<Either<Failure, List<CategoriesEntity>>> call();
}
