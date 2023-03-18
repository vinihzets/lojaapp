import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';

abstract class HomeDataSource {
  Future<Either<Failure, void>> signOut();
}
