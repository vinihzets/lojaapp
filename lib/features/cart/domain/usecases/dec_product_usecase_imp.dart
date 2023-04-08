import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../repositories/cart_repository.dart';
import 'dec_product_usecase.dart';

import '../../data/dto/cart_products_dto.dart';

class DecProductUseCaseImp implements DecProductUseCase {
  CartRepository cartRepository;

  DecProductUseCaseImp(this.cartRepository);

  @override
  Future<Either<Failure, void>> decProduct(CartProductsDto cartProductsDto) {
    return cartRepository.decProduct(cartProductsDto);
  }
}
