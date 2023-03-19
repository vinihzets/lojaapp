import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/home/data/datasources/home_datasources.dart';
import 'package:lojaapp/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  HomeDataSource homeDataSource;

  HomeRepositoryImp(this.homeDataSource);

  @override
  Future<Either<Failure, void>> signOut() {
    return homeDataSource.signOut();
  }
}
