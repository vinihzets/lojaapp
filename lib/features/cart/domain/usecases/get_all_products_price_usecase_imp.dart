import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';
import 'package:lojaapp/features/cart/domain/repositories/cart_repository.dart';
import 'package:lojaapp/features/cart/domain/usecases/get_all_products_price_usecase.dart';

class GetAllProductsPriceUseCaseImp implements GetAllProductsPriceUseCase {
  CartRepository cartRepository;

  GetAllProductsPriceUseCaseImp(this.cartRepository);

  @override
  Future<Either<Failure, dynamic>> getPrice(CartProductsDto cartProductsDto) {
    return cartRepository.getPrice(cartProductsDto);
  }
}
