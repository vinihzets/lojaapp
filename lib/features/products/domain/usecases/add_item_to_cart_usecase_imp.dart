import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../../data/dtos/products_dto.dart';
import '../repositories/products_repository.dart';
import 'add_item_to_cart_usecase.dart';

class AddItemToCartUseCaseImp implements AddItemToCartUseCase {
  ProductsRepository productsRepository;

  AddItemToCartUseCaseImp(this.productsRepository);

  @override
  Future<Either<Failure, dynamic>> call(ProductsDto productsDto) {
    return productsRepository.addItemToCart(productsDto);
  }
}
