import 'package:dartz/dartz.dart';
import 'package:lojaapp/core/failure/failure.dart';
import 'package:lojaapp/features/home/domain/repositories/home_repository.dart';
import 'package:lojaapp/features/home/domain/usecases/use_case.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  HomeRepository homeRepository;

  SignOutUseCase(this.homeRepository);

  @override
  Future<Either<Failure, void>> call({required NoParams params}) {
    return homeRepository.signOut();
  }
}
