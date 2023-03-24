import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/categories/domain/entities/categories_entity.dart';
import 'package:lojaapp/features/products/data/dtos/products_dto.dart';
import 'package:lojaapp/features/products/domain/entities/products_entity.dart';
import 'package:lojaapp/features/products/domain/usecases/add_item_to_cart_usecase.dart';
import 'package:lojaapp/features/products/domain/usecases/usecase.dart';
import 'package:lojaapp/features/products/presentation/bloc/products_event.dart';
import 'package:lojaapp/main.dart';

mixin HudMixins {
  showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  navigate(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }
}

class ProductsBloc with HudMixins {
  UseCase useCase;
  AddItemToCartUseCase addItemToCartUseCase;

  late StreamController<ProductsEvent> _event;
  Sink<ProductsEvent> get event => _event.sink;

  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  ProductsBloc(this.useCase, this.addItemToCartUseCase) {
    _event = StreamController.broadcast();
    _state = StreamController.broadcast();

    _event.stream.listen(_mapEventState);
  }

  dispatchEvent(ProductsEvent event) {
    _event.add(event);
  }

  _mapEventState(ProductsEvent event) {
    if (event is ProductsEventGet) {
      getProducts(event.context);
    } else if (event is ProductsEventNavigateDetails) {
      navigateToDetails(event.context, event.entity);
    } else if (event is ProductsEventAddToCart) {
      addToCart(event.context, event.productsDto);
    }
  }

  navigateToDetails(BuildContext context, ProductsEntity entity) {
    Navigator.of(context)
        .pushNamed(gConsts.productsDetailsScreen, arguments: entity);
  }

  getProducts(BuildContext context) async {
    CategoriesEntity categories =
        ModalRoute.of(context)!.settings.arguments as CategoriesEntity;

    final productsRequest = await useCase(categories.id);

    productsRequest.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      _dispatchState(BlocStableState(data: r));
    });
  }

  addToCart(BuildContext context, ProductsDto productsDto) async {
    final cartRequest = await addItemToCartUseCase(productsDto);

    cartRequest.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      showSnackBar(context, 'Item adicionado com sucesso ao carrinho!!');
      navigate(context, gConsts.cartScreen);
      _dispatchState(BlocStableState(data: r));
    });
  }

  _dispatchState(BlocState state) {
    _state.add(state);
  }
}
