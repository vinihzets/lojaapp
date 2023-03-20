import 'package:flutter/material.dart';
import 'package:lojaapp/features/products/domain/entities/products_entity.dart';

class GridProductTile extends StatelessWidget {
  List<ProductsEntity> listProducts;

  GridProductTile({required this.listProducts, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: listProducts
            .map((e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      e.imageUrl,
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        e.name,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        e.price,
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }
}
