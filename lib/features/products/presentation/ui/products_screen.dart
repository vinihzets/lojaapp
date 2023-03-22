import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lojaapp/core/architeture/bloc_builder.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/categories/domain/entities/categories_entity.dart';
import 'package:lojaapp/features/products/domain/entities/products_entity.dart';
import 'package:lojaapp/features/products/presentation/bloc/products_bloc.dart';
import 'package:lojaapp/features/products/presentation/bloc/products_event.dart';
import 'package:lojaapp/features/products/presentation/widgets/grid_product_tile.dart';
import 'package:lojaapp/features/products/presentation/widgets/list_product_tile.dart';

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
                List<ProductsEntity> listProducts = state.data;

                return TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      GridView.builder(
                          itemCount: 8,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 4.0,
                                  crossAxisSpacing: 4.0,
                                  childAspectRatio: 0.65),
                          itemBuilder: (context, index) {
                            return GridProductTile(
                              listProducts: listProducts,
                              bloc: bloc,
                            );
                          }),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: 6,
                          padding: const EdgeInsets.all(4),
                          itemBuilder: (context, index) {
                            return ListProductTile(
                              listProducts: listProducts,
                              bloc: bloc,
                            );
                          })
                    ]);
              } else {
                return const SizedBox.shrink();
              }
            }),
      ),
    );
  }
}
