import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lojaapp/core/architeture/bloc_builder.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';
import 'package:lojaapp/features/categories/domain/entities/categories_entity.dart';
import 'package:lojaapp/features/products/presentation/bloc/products_bloc.dart';
import 'package:lojaapp/features/products/presentation/bloc/products_event.dart';

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

    return Scaffold(
        appBar: AppBar(),
        body: BlocScreenBuilder(
            stream: bloc.state,
            builder: (state) {
              if (state is BlocStableState) {
                return const SizedBox.shrink();
              }
              return const SizedBox.shrink();
            }));
  }
}
