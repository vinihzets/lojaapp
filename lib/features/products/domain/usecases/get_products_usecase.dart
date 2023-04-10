import 'package:lojaapp/core/global/product_entity.dart';

import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../repositories/products_repository.dart';
import 'usecase.dart';

class GetProductsUseCase implements UseCase {
  ProductsRepository productsRepository;

  GetProductsUseCase(this.productsRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(String uid) {
    return productsRepository.getProducts(uid);
  }
}
