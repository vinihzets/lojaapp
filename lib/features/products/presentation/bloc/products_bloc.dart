import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/categories/domain/entities/categories_entity.dart';
import 'package:lojaapp/features/products/domain/usecases/usecase.dart';
import 'package:lojaapp/features/products/presentation/bloc/products_event.dart';

class ProductsBloc {
  UseCase useCase;

  late StreamController<ProductsEvent> _event;
  Sink<ProductsEvent> get event => _event.sink;

  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  ProductsBloc(this.useCase) {
    _event = StreamController.broadcast();
    _state = StreamController.broadcast();

    _event.stream.listen(_mapEventState);
  }

  _dispatchEvent(ProductsEvent event) {
    _event.add(event);
  }

  _mapEventState(ProductsEvent event) {
    if (event is ProductsEventGet) {
      getProducts(event.context);
    }
  }

  getProducts(BuildContext context) async {
    CategoriesEntity categories =
        ModalRoute.of(context)!.settings.arguments as CategoriesEntity;

    final productsRequest = await useCase(categories.id);

    productsRequest.fold((l) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l.message)));
    }, (r) {
      _dispatchState(BlocStableState(data: r));
    });
  }

  _dispatchState(BlocState state) {
    _state.add(state);
  }
}
