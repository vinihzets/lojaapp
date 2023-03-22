import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';
import 'package:lojaapp/features/cart/domain/repositories/cart_repository.dart';
import 'package:lojaapp/features/cart/domain/usecases/inc_product_usecase.dart';

class IncProductUseCaseImp implements IncProductUseCase {
  CartRepository cartRepository;

  IncProductUseCaseImp(this.cartRepository);

  @override
  Future<Either<Failure, void>> incProduct(CartProductsDto cartProductsDto) {
    return cartRepository.incProduct(cartProductsDto);
  }
}
