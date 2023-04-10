import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lojaapp/features/home/domain/entities/product_entity.dart';
import 'package:lojaapp/features/home/presentation/widgets/news_product_tile.dart';
import '../../../../core/architeture/bloc_state.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../widgets/custom_drawer_widgets.dart';
import '../../../../core/architeture/bloc_builder.dart';

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

    bloc.event.add(HomeEventGetNews(context));
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
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocScreenBuilder(
                stream: bloc.state,
                builder: (state) {
                  if (state is BlocStableState) {
                    final List<ProductEntity> list = state.data;
                    return GridView.builder(
                        itemCount: list.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 4.0,
                                childAspectRatio: 0.65),
                        itemBuilder: (context, index) {
                          final product = list[index];
                          return NewsProductTile(product: product, bloc: bloc);
                        });
                  } else if (state is BlocLoadingState) {
                    return const CircularProgressIndicator();
                  }

                  return Container();
                }))
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          //  bloc.event
          // .add(HomeEventDrawerNavigate(context, gConsts.cartScreen));
        },
        child: const Icon(Icons.card_travel_rounded),
      ),
    );
  }
}
