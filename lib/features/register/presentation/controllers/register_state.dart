abstract class RegisterState<T> {
  T? data;
  RegisterState({required this.data});
}

class BlocStableState<T> extends RegisterState<T> {
  BlocStableState({required super.data});
}

class BlocLoadingState<T> extends RegisterState<T> {
  BlocLoadingState({required super.data});
}

class BlocEmptyState<T> extends RegisterState<T> {
  BlocEmptyState({required super.data});
}

class BlocErrorState<T> extends RegisterState<T> {
  final String message;
  BlocErrorState({required this.message, super.data});
}
