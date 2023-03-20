import 'package:flutter/material.dart';
import 'package:lojaapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:lojaapp/features/home/presentation/bloc/home_event.dart';
import 'package:lojaapp/features/home/presentation/widgets/drawer_tile_widgets.dart';
import 'package:lojaapp/main.dart';

class CustomDrawer extends StatelessWidget {
  HomeBloc bloc;

  CustomDrawer({required this.bloc, super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    Widget buildDrawer() => Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 243, 161, 123),
            Color.fromARGB(255, 229, 246, 252)
          ], begin: Alignment.topLeft, end: Alignment.bottomLeft)),
        );

    return Drawer(
        child: Stack(children: [
      buildDrawer(),
      Positioned(
          top: width / 2 - 150,
          left: width / 2 - 180,
          bottom: 0,
          child: const Text(
            'Find Wear Clothings',
            style: TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          )),
      Positioned(
          top: width / 2 - 100,
          left: width / 2 - 160,
          bottom: 0,
          child: Column(
            children: [
              const Divider(),
              DrawerTile(
                onPressed: () {
                  bloc.event.add(
                      HomeEventDrawerNavigate(context, gConsts.homeScreen));
                  bloc.event.add(HomeEventGetCategories());
                },
                icon: Icons.home,
                text: 'Home',
              ),
              DrawerTile(
                  onPressed: () => bloc.event.add(
                      HomeEventDrawerNavigate(context, gConsts.homeScreen)),
                  icon: Icons.location_on,
                  text: 'Localizacao'),
              DrawerTile(
                  onPressed: () => bloc.event.add(HomeEventDrawerNavigate(
                      context, gConsts.categoriesScreen)),
                  icon: Icons.list,
                  text: 'Categorias'),
              DrawerTile(
                  onPressed: () => bloc.event.add(
                      HomeEventDrawerNavigate(context, gConsts.homeScreen)),
                  icon: Icons.playlist_add_check,
                  text: 'Meus Pedidos'),
            ],
          ))
    ]));
  }
}
