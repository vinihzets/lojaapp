import 'dart:async';
import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../data/dto/cart_products_dto.dart';

abstract class GetItemsCart {
  Future<Either<Failure, List<CartProductsDto>>> call();
}
