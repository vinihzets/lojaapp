import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/cart/data/dto/cart_products_dto.dart';
import 'package:lojaapp/features/cart/domain/usecases/add_item_cart_usecase.dart';
import 'package:lojaapp/features/cart/domain/usecases/dec_product_usecase.dart';
import 'package:lojaapp/features/cart/domain/usecases/inc_product_usecase.dart';
import 'package:lojaapp/features/cart/domain/usecases/remove_item_cart_usecase.dart';
import 'package:lojaapp/features/cart/presentation/bloc/cart_event.dart';
import 'package:lojaapp/main.dart';

class SnackMixin {
  void showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

class CartBloc with SnackMixin {
  AddCartUseCase addCartUseCase;
  RemoveItemCartUseCase removeItemCartUseCase;
  IncProductUseCase incProductUseCase;
  DecProductUseCase decProductUseCase;

  CartBloc(this.addCartUseCase, this.removeItemCartUseCase,
      this.incProductUseCase, this.decProductUseCase) {
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
    } else if (event is CartEventRemoveItem) {
      removeItemToCart(event.context, event.id);
    } else if (event is CartEventIncItem) {
      incItem(event.context, event.cartProductsDto);
    } else if (event is CartEventDecItem) {
      decItem(event.context, event.cartProductsDto);
    }
  }

  addItemToCart(BuildContext context) async {
    final itemAddRequest = await addCartUseCase();

    itemAddRequest.fold((l) {
      showSnack(context, l.message);
    }, (r) {
      _dispatchState(BlocStableState(data: r));
    });
  }

  incItem(BuildContext context, CartProductsDto cartProductsDto) async {
    final incRequest = await incProductUseCase.incProduct(cartProductsDto);

    incRequest.fold((l) {
      showSnack(context, l.message);
    }, (r) {
      r;
    });
  }

  decItem(BuildContext context, CartProductsDto cartProductsDto) async {
    final decRequest = await decProductUseCase.decProduct(cartProductsDto);

    decRequest.fold((l) {
      showSnack(context, l.message);
    }, (r) {
      r;
    });
  }

  removeItemToCart(BuildContext context, String id) async {
    final removeitemRequest = await removeItemCartUseCase(id);

    removeitemRequest.fold((l) {
      showSnack(context, l.message);
    }, (r) {
      r;
    });
  }
}
