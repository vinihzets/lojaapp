import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/home/presentation/controllers/home_bloc.dart';
import 'package:lojaapp/features/home/presentation/controllers/home_event.dart';
import 'package:lojaapp/features/home/presentation/widgets/custom_drawer_widgets.dart';

class BlocScrenBuilder extends StatelessWidget {
  final Stream<BlocState> stream;
  final Widget Function(BlocState) builder;

  const BlocScrenBuilder(
      {required this.stream, required this.builder, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return builder(snapshot.data!);
          }
          return const SizedBox.shrink();
        });
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();
    super.initState();
  }

  Widget buildGradientColor() => Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 211, 118, 130),
          Color.fromARGB(255, 253, 181, 168)
        ], begin: Alignment.topLeft, end: Alignment.bottomLeft)),
      );

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Novidades',
          style: TextStyle(
              fontSize: 26,
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Builder(
            builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(
                    Icons.list_rounded,
                    color: Colors.white,
                  ),
                )),
        actions: [
          TextButton(
              onPressed: () => bloc.event.add(HomeEventSignOut(context)),
              child: const Text(
                'Sair',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      drawer: CustomDrawer(bloc: bloc),
      body: Stack(children: [
        buildGradientColor(),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocScrenBuilder(
                stream: bloc.state,
                builder: (state) {
                  if (state is BlocStableState) {
                    return Text(' Tudo ok!');
                  } else if (state is BlocLoadingState) {
                    return CircularProgressIndicator();
                  }

                  return Container();
                }))
      ]),
    );
  }
}
