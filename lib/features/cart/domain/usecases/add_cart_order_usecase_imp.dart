import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../../data/dto/cart_products_dto.dart';
import '../repositories/cart_repository.dart';
import 'add_cart_order_usecase.dart';

class AddCartOrderUseCaseImp implements AddCartOrderUseCase {
  CartRepository cartRepository;

  AddCartOrderUseCaseImp(this.cartRepository);
  @override
  Future<Either<Failure, void>> addOrder(
    List<CartProductsDto> cartProductsDto,
    double productsPrice,
    double discount,
    double totalPrice,
  ) {
    return cartRepository.addOrder(
        cartProductsDto, productsPrice, discount, totalPrice);
  }
}
