import 'package:flutter/material.dart';
import 'package:lojaapp/core/architeture/bloc_builder.dart';

class CartPriceTile extends StatelessWidget {
  final VoidCallback buy;
  CartPriceTile({required this.buy, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Resumo do pedido',
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              children: const [
                Expanded(child: Text('Subtotal')),
                Text('R\$ 0.0')
              ],
            ),
            Divider(),
            Row(
              children: const [
                Expanded(child: Text('Desconto')),
                Text('R\$ 0.0')
              ],
            ),
            Divider(),
            Row(
              children: const [
                Expanded(child: Text('Entrega')),
                Text('R\$ 0.0')
              ],
            ),
            Divider(),
            SizedBox(
              height: 12,
            ),
            Row(
              children: const [
                Expanded(child: Text('Total')),
                Text(
                  'R\$ 0.0',
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            SizedBox(
                width: 360,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                    onPressed: buy,
                    child: Text('Comprar')))
          ],
        ),
      ),
    );
  }
}
