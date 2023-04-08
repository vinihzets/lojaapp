import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../data/dto/cart_products_dto.dart';

abstract class AddCartOrderUseCase {
  Future<Either<Failure, void>> addOrder(
    List<CartProductsDto> cartProductsDto,
    double productsPrice,
    double discount,
    double totalPrice,
  );
}
