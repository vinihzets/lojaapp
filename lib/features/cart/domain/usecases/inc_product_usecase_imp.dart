import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../../data/dto/cart_products_dto.dart';
import '../repositories/cart_repository.dart';
import 'inc_product_usecase.dart';

class IncProductUseCaseImp implements IncProductUseCase {
  CartRepository cartRepository;

  IncProductUseCaseImp(this.cartRepository);

  @override
  Future<Either<Failure, void>> incProduct(CartProductsDto cartProductsDto) {
    return cartRepository.incProduct(cartProductsDto);
  }
}
