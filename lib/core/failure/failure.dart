abstract class Failure {
  String message;

  Failure({required this.message});
}

class RemoteFailure extends Failure {
  RemoteFailure({required super.message});
}

class CachedFailure extends Failure {
  CachedFailure({required super.message});
}
