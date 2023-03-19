import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lojaapp/core/architeture/bloc_state.dart';

class BlocScreenBuilder extends StatelessWidget {
  final Stream<BlocState> stream;
  final Widget Function(BlocState) builder;

  const BlocScreenBuilder(
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
