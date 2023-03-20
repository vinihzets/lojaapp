import 'dart:async';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:lojaapp/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:lojaapp/features/categories/presentation/bloc/categories_event.dart';

class CategoriesBloc {
  GetCategoriesUseCase getCategoriesUseCase;

  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  late StreamController<BlocCategoriesEvent> _event;
  Sink<BlocCategoriesEvent> get event => _event.sink;

  CategoriesBloc(
    this.getCategoriesUseCase,
  ) {
    _state = StreamController.broadcast();
    _event = StreamController.broadcast();

    _event.stream.listen(_mapEventState(BlocCategoriesEventGetCategories()));
  }

  _dispatchState(BlocState state) {
    _state.add(state);
  }

  sendEvent(BlocCategoriesEvent event) {
    _event.add(event);
  }

  getCategories() async {
    final getRequest = await getCategoriesUseCase(params: NoParams());

    getRequest.fold((l) {}, (r) {
      _dispatchState(BlocStableState(data: r));
    });
  }

  _mapEventState(BlocCategoriesEvent event) {
    if (event is BlocCategoriesEventGetCategories) {
      getCategories();
    } else if (event is BlocCategoriesEventNavigateToCategorie) {
      //  navigateToCategorie(event);
    }
  }

  navigateToProducts(BuildContext context, String routeName, args) {
    Navigator.of(context).pushNamed(routeName, arguments: args);
  }
}
