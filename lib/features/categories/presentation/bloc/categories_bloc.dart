import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojaapp/core/architeture/bloc_event.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/categories/domain/usecases/get_categories_usecase.dart';

class CategoriesBloc {
  GetCategoriesUseCase getCategoriesUseCase;

  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  late StreamController<BlocEvent> _event;
  Sink<BlocEvent> get event => _event.sink;

  CategoriesBloc(
    this.getCategoriesUseCase,
  ) {
    _state = StreamController.broadcast();
    _event = StreamController.broadcast();

    _event.stream.listen(_mapEventState(BlocEventGetCategories()));
  }

  _handlerEvent(BlocEvent event) {
    _event.add(event);
  }

  _dispatchState(BlocState state) {
    _state.add(state);
  }

  getCategories() async {
    final getRequest = await getCategoriesUseCase(params: NoParams());

    getRequest.fold((l) {}, (r) {
      _dispatchState(BlocStableState(data: r));
    });
  }

  _mapEventState(BlocEvent event) {
    if (event is BlocEventGetCategories) {
      getCategories();
    } else {}
  }
}
