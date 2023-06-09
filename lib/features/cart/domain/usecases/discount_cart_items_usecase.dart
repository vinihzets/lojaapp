import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';

abstract class DiscountCardItemUseCase {
  Future<Either<Failure, DocumentSnapshot>> couponVerify(String coupon);
}
