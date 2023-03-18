import 'package:flutter/material.dart';
import 'package:lojaapp/features/home/presentation/controllers/home_bloc.dart';
import 'package:lojaapp/features/home/presentation/controllers/home_event.dart';
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
                  onPressed: () => bloc.event.add(HomeEventDrawerNavigateToHome(
                      context, gConsts.homeScreen)),
                  icon: Icons.home,
                  text: 'Home'),
              DrawerTile(
                  onPressed: () {},
                  icon: Icons.location_on,
                  text: 'Localizacao'),
              DrawerTile(
                  onPressed: () {},
                  icon: Icons.playlist_add_check,
                  text: 'Meus Pedidos'),
            ],
          ))
    ]));
  }
}
