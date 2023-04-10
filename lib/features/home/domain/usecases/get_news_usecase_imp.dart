import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/home/domain/entities/product_entity.dart';
import 'package:lojaapp/features/home/domain/repositories/home_repository.dart';
import 'package:lojaapp/features/home/domain/usecases/get_news_usecase.dart';

class GetNewsUseCaseImp implements GetNewsUseCase {
  HomeRepository homeRepository;

  GetNewsUseCaseImp(this.homeRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> getNews() {
    return homeRepository.getNews();
  }
}
