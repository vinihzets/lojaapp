import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lojaapp/core/utils/hud_mixins.dart';
import 'package:lojaapp/features/home/domain/usecases/get_news_usecase.dart';
import '../../../../core/architeture/bloc_state.dart';
import '../../domain/usecases/use_case.dart';
import 'home_event.dart';
import '../../../../main.dart';

import '../../domain/usecases/sign_out_usecase.dart';

class HomeBloc with HudMixins {
  SignOutUseCase signOutUseCase;
  GetNewsUseCase getNewsUseCase;

  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  late StreamController<HomeEvent> _event;
  Sink<HomeEvent> get event => _event.sink;

  HomeBloc(this.signOutUseCase, this.getNewsUseCase) {
    _state = StreamController.broadcast();
    _event = StreamController.broadcast();

    _event.stream.listen(_dispatchEvent);
  }

  _dispatchState(BlocState state) {
    _state.add(state);
  }

  _dispatchEvent(HomeEvent event) {
    if (event is HomeEventDrawerNavigate) {
      navigate(event.context, event.routeName);
    } else if (event is HomeEventSignOut) {
      signOut(event.context);
    } else if (event is HomeEventGetNews) {
      getNews(event.context);
    } else if (event is HomeEventNavigateToDetails) {
      navigateThenArgs(
          event.context, gConsts.productsDetailsScreen, event.entity);
    }
  }

  signOut(BuildContext context) async {
    final requestSignOut = await signOutUseCase(params: NoParams());

    requestSignOut.fold((l) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l.message)));
    }, (r) {
      navigate(context, gConsts.loginScreen);
    });
  }

  getNews(BuildContext context) async {
    final getRequest = await getNewsUseCase.getNews();
    getRequest.fold((l) {
      showSnack(context, l.message);
    }, (r) {
      _dispatchState(BlocStableState(data: r));
    });
  }
}
