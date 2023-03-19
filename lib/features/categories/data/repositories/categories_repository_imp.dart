import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/features/categories/data/datasources/categories_datasource.dart';
import 'package:lojaapp/features/categories/domain/entities/categories_entity.dart';
import 'package:lojaapp/features/categories/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImp implements CategoriesRepository {
  CategoriesDataSource categoriesDataSource;

  CategoriesRepositoryImp(this.categoriesDataSource);

  @override
  Future<Either<Failure, List<CategoriesEntity>>> call() {
    return categoriesDataSource();
  }
}
