import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/categories/domain/entities/categories_entity.dart';
import 'package:lojaapp/features/categories/domain/repositories/categories_repository.dart';
import 'package:lojaapp/features/home/domain/usecases/use_case.dart';

class NoParams {}

class GetCategoriesUseCase
    implements UseCase<List<CategoriesEntity>, NoParams> {
  CategoriesRepository categoriesRepository;

  GetCategoriesUseCase(this.categoriesRepository);

  @override
  Future<Either<Failure, List<CategoriesEntity>>> call(
      {required NoParams params}) {
    return categoriesRepository();
  }
}
