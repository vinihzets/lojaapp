import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lojaapp/core/global/product_entity.dart';
import '../../../../core/architeture/bloc_builder.dart';
import '../../../../core/architeture/bloc_state.dart';
import '../../../categories/domain/entities/categories_entity.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';
import '../widgets/grid_product_tile.dart';
import '../widgets/list_product_tile.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ProductsBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoriesEntity categories =
        ModalRoute.of(context)!.settings.arguments as CategoriesEntity;
    bloc.event.add(ProductsEventGet(context, categories.id));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.grid_on),
            ),
            Tab(
              icon: Icon(Icons.list),
            )
          ]),
        ),
        body: BlocScreenBuilder(
            stream: bloc.state,
            builder: (state) {
              if (state is BlocStableState) {
                List<ProductEntity> listProducts = state.data;

                return TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      GridView.builder(
                          itemCount: listProducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 4.0,
                                  crossAxisSpacing: 4.0,
                                  childAspectRatio: 0.65),
                          itemBuilder: (context, index) {
                            final product = listProducts[index];
                            return GridProductTile(
                                product: product, bloc: bloc);
                          }),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: listProducts.length,
                          padding: const EdgeInsets.all(4),
                          itemBuilder: (context, index) {
                            final product = listProducts[index];
                            return ListProductTile(
                              product: product,
                              bloc: bloc,
                            );
                          })
                    ]);
              } else {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.remove_shopping_cart_sharp,
                      size: 68,
                    ),
                    Text(
                      'Essa categoria nao possui produto cadastrado ainda !!',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ));
              }
            }),
      ),
    );
  }
}
