abstract class BlocState<T> {
  T? data;
  BlocState({required this.data});
}

class BlocStableState<T> extends BlocState<T> {
  BlocStableState({required super.data});
}

class BlocLoadingState<T> extends BlocState<T> {
  BlocLoadingState({required super.data});
}

class BlocEmptyState<T> extends BlocState<T> {
  BlocEmptyState({required super.data});
}

class BlocErrorState<T> extends BlocState<T> {
  final String message;
  BlocErrorState({required this.message, super.data});
}
