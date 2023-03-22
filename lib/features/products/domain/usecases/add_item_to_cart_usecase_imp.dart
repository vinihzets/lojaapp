import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/features/products/data/dtos/products_dto.dart';
import 'package:lojaapp/features/products/domain/repositories/products_repository.dart';
import 'package:lojaapp/features/products/domain/usecases/add_item_to_cart_usecase.dart';

class AddItemToCartUseCaseImp implements AddItemToCartUseCase {
  ProductsRepository productsRepository;

  AddItemToCartUseCaseImp(this.productsRepository);

  @override
  Future<Either<Failure, dynamic>> call(ProductsDto productsDto) {
    return productsRepository.addItemToCart(productsDto);
  }
}
