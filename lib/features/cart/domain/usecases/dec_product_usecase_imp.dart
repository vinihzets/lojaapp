import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/features/cart/domain/repositories/cart_repository.dart';
import 'package:lojaapp/features/cart/domain/usecases/dec_product_usecase.dart';

import '../../data/dto/cart_products_dto.dart';

class DecProductUseCaseImp implements DecProductUseCase {
  CartRepository cartRepository;

  DecProductUseCaseImp(this.cartRepository);

  @override
  Future<Either<Failure, void>> decProduct(CartProductsDto cartProductsDto) {
    return cartRepository.decProduct(cartProductsDto);
  }
}
