import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../datasources/categories_datasource.dart';
import '../../domain/entities/categories_entity.dart';
import '../../domain/repositories/categories_repository.dart';

class CategoriesRepositoryImp implements CategoriesRepository {
  CategoriesDataSource categoriesDataSource;

  CategoriesRepositoryImp(this.categoriesDataSource);

  @override
  Future<Either<Failure, List<CategoriesEntity>>> call() {
    return categoriesDataSource();
  }
}
