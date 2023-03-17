import 'package:lojaapp/core/failure/failure.dart';
import 'package:dartz/dartz.dart';

import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterDataSource {
  Future<Either<Failure, UserCredential>> register(
      String email, String password);
}
