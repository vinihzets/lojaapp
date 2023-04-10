import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lojaapp/core/global/product_dto.dart';
import 'package:lojaapp/core/global/product_entity.dart';
import 'package:lojaapp/core/utils/hud_mixins.dart';
import '../../../../core/architeture/bloc_state.dart';
import '../../../categories/domain/entities/categories_entity.dart';
import '../../domain/usecases/add_item_to_cart_usecase.dart';
import '../../domain/usecases/usecase.dart';
import 'products_event.dart';
import '../../../../main.dart';

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

  navigateToDetails(BuildContext context, ProductEntity entity) {
    Navigator.of(context)
        .pushNamed(gConsts.productsDetailsScreen, arguments: entity);
  }

  getProducts(BuildContext context) async {
    CategoriesEntity categories =
        ModalRoute.of(context)!.settings.arguments as CategoriesEntity;

    final productsRequest = await useCase(categories.id);

    productsRequest.fold((l) {
      showSnack(context, l.message);
    }, (r) {
      if (r.isNotEmpty) {
        _dispatchState(BlocStableState(data: r));
      } else if (r.isEmpty) {
        _dispatchState(BlocEmptyState());
      }
    });
  }

  addToCart(BuildContext context, ProductDto productsDto) async {
    final cartRequest = await addItemToCartUseCase(productsDto);

    cartRequest.fold((l) {
      showSnack(context, l.message);
    }, (r) {
      showSnack(context, 'Item adicionado com sucesso ao carrinho!!');
      navigate(context, gConsts.cartScreen);
      _dispatchState(BlocStableState(data: r));
    });
  }

  _dispatchState(BlocState state) {
    _state.add(state);
  }
}
