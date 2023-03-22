import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';

abstract class DiscountCardItemUseCase {
  Future<Either<Failure, DocumentSnapshot>> discountItem(String coupon);
}
