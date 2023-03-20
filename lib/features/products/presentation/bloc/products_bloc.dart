import 'dart:async';

import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/products/presentation/bloc/products_event.dart';

class ProductsBloc {
  late StreamController<ProductsEvent> _event;
  Sink<ProductsEvent> get event => _event.sink;

  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  ProductsBloc() {
    _event = StreamController();
    _state = StreamController();
  }

  _dispatchEvent(ProductsEvent event) {
    _event.add(event);
  }

  _dispatchState(BlocState state) {
    _state.add(state);
  }
}
