import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../repositories/home_repository.dart';
import 'use_case.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  HomeRepository homeRepository;

  SignOutUseCase(this.homeRepository);

  @override
  Future<Either<Failure, void>> call({required NoParams params}) {
    return homeRepository.signOut();
  }
}
