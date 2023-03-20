import 'package:flutter/material.dart';
import 'package:lojaapp/features/products/domain/entities/products_entity.dart';
import 'package:lojaapp/features/products/presentation/bloc/products_bloc.dart';
import 'package:lojaapp/features/products/presentation/bloc/products_event.dart';

class ListProductTile extends StatelessWidget {
  List<ProductsEntity> listProducts;
  ProductsBloc bloc;

  ListProductTile({required this.listProducts, required this.bloc, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: listProducts
          .map((e) => GestureDetector(
                onTap: () =>
                    bloc.event.add(ProductsEventNavigateDetails(context, e)),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    children: [
                      Image.network(
                        e.imageUrl,
                        fit: BoxFit.cover,
                        height: 250,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              e.name,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              e.price,
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
