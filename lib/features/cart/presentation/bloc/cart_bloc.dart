import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';
import 'package:lojaapp/features/cart/domain/usecases/add_cart_usecase.dart';
import 'package:lojaapp/features/cart/presentation/bloc/cart_event.dart';

class CartBloc {
  AddCartUseCase addCartUseCase;

  CartBloc(this.addCartUseCase) {
    _event = StreamController();
    _state = StreamController();

    _event.stream.listen(_mapListenEvent);
  }

  late StreamController<CartEvent> _event;
  Sink<CartEvent> get event => _event.sink;

  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  dispatchEvent(CartEvent event) {
    _event.add(event);
  }

  _dispatchState(BlocState state) {
    _state.add(state);
  }

  _mapListenEvent(CartEvent event) {
    if (event is CartEventAddItem) {
      addItemToCart(event.context);
    }
  }

  addItemToCart(BuildContext context) async {
    final itemAddRequest = await addCartUseCase();

    itemAddRequest.fold((l) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l.message)));
    }, (r) {
      _dispatchState(BlocStableState(data: r));
    });
  }
}
