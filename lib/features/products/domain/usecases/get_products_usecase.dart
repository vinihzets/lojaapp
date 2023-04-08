import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/products_entity.dart';
import '../repositories/products_repository.dart';
import 'usecase.dart';

class GetProductsUseCase implements UseCase {
  ProductsRepository productsRepository;

  GetProductsUseCase(this.productsRepository);

  @override
  Future<Either<Failure, List<ProductsEntity>>> call(String uid) {
    return productsRepository.getProducts(uid);
  }
}
