import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../bloc/initialize_bloc.dart';

class InitializeScreen extends StatefulWidget {
  const InitializeScreen({super.key});

  @override
  State<InitializeScreen> createState() => _InitializeScreenState();
}

class _InitializeScreenState extends State<InitializeScreen> {
  late InitializeBloc bloc;
  final getIt = GetIt.I;

  @override
  void initState() {
    bloc = getIt.get();

    super.initState();
    Future.delayed(const Duration(seconds: 3))
        .then((value) => bloc.isLogged(context));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
