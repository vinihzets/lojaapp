import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/global/product_dto.dart';
import '../../../../core/failure/failure.dart';
import '../datasources/home_datasources.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  HomeDataSource homeDataSource;

  HomeRepositoryImp(this.homeDataSource);

  @override
  Future<Either<Failure, void>> signOut() {
    return homeDataSource.signOut();
  }

  @override
  Future<Either<Failure, List<ProductDto>>> getNews() {
    return homeDataSource.getNews();
  }
}
