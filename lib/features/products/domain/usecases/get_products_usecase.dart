import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/features/products/domain/entities/products_entity.dart';
import 'package:lojaapp/features/products/domain/repositories/products_repository.dart';
import 'package:lojaapp/features/products/domain/usecases/usecase.dart';

class GetProductsUseCase implements UseCase {
  ProductsRepository productsRepository;

  GetProductsUseCase(this.productsRepository);

  @override
  Future<Either<Failure, List<ProductsEntity>>> call(String uid) {
    return productsRepository.getProducts(uid);
  }
}
