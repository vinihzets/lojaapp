import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lojaapp/core/failure/failure.dart';

abstract class LoginDataSource {
  Future<Either<Failure, UserCredential>> login(String email, String password);
}
