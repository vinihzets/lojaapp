import 'package:flutter/material.dart';
import 'package:lojaapp/features/products/domain/entities/products_entity.dart';

class ListProductTile extends StatelessWidget {
  List<ProductsEntity> listProducts;

  ListProductTile({required this.listProducts, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: listProducts
          .map((e) => Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.network(
                        e.imageUrl,
                        fit: BoxFit.cover,
                        height: 250,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
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
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
