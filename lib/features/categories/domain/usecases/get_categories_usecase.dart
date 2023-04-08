import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/categories_entity.dart';
import '../repositories/categories_repository.dart';
import '../../../home/domain/usecases/use_case.dart';

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
