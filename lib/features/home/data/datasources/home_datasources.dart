import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';

abstract class HomeDataSource {
  Future<Either<Failure, void>> signOut();
}
