import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../repositories/cart_repository.dart';
import 'remove_item_cart_usecase.dart';

class RemoveItemCartUseCaseImp implements RemoveItemCartUseCase {
  CartRepository cartRepository;

  RemoveItemCartUseCaseImp(this.cartRepository);

  @override
  Future<Either<Failure, void>> call(String id) {
    return cartRepository.removeCartItems(id);
  }
}
