import 'dart:async';
import '../../../../core/architeture/bloc_state.dart';
import 'package:flutter/material.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import 'categories_event.dart';

mixin NavigateMixin {
  void navigateWithaArguments(
      BuildContext context, String routeName, Object? args) {
    Navigator.of(context).pushNamed(routeName, arguments: args);
  }

  void navigate(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }
}

class CategoriesBloc with NavigateMixin {
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

    _event.stream.listen(_mapEventState);
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
      if (r.isNotEmpty) {
        _dispatchState(BlocStableState(data: r));
      } else if (r.isEmpty) {
        _dispatchState(BlocEmptyState());
      }
    });
  }

  _mapEventState(BlocCategoriesEvent event) {
    if (event is BlocCategoriesEventGetCategories) {
      getCategories();
    } else if (event is BlocCategoriesEventNavigateToProductDetails) {
      navigateWithaArguments(event.context, event.routeName, event.arguments);
    } else if (event is BlocCategoriesEventNavigate) {
      navigate(event.context, event.routeName);
    }
  }
}
