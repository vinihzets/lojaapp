import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lojaapp/core/architeture/bloc_builder.dart';
import 'package:lojaapp/features/categories/domain/entities/categories_entity.dart';
import 'package:lojaapp/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:lojaapp/features/categories/presentation/bloc/categories_event.dart';
import 'package:lojaapp/main.dart';

import '../../../../core/architeture/bloc_state.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late CategoriesBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();
    bloc.event.add(BlocCategoriesEventGetCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: BlocScreenBuilder(
        stream: bloc.state,
        builder: (state) {
          if (state is BlocStableState) {
            List<CategoriesEntity> categories = state.data!;

            return ListView(
              children: categories
                  .map((e) => GestureDetector(
                      child: ListTile(
                          leading: Image.network(e.imageCategory),
                          trailing: const Icon(
                            Icons.arrow_right_alt,
                            color: Colors.black,
                          ),
                          title: Text(e.name)),
                      onTap: () => bloc.event.add(
                          BlocCategoriesEventNavigateToProductDetails(
                              context, gConsts.productsScreen, e))))
                  .toList(),
            );
          } else if (state is BlocLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => bloc.event
            .add(BlocCategoriesEventNavigate(context, gConsts.cartScreen)),
        child: const Icon(
          Icons.card_travel_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
