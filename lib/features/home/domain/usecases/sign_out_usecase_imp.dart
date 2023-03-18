import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/home/domain/repositories/home_repository.dart';
import 'package:lojaapp/features/home/domain/usecases/sign_out_usecase.dart';

class SignOutUseCaseImp implements SignOutUseCase {
  HomeRepository homeRepository;

  SignOutUseCaseImp(this.homeRepository);

  Future<Either<Failure, void>> signOut() {
    return homeRepository.signOut();
  }
}
