import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lojaapp/features/register/presentation/bloc/register_bloc.dart';

import '../widgets/build_column_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late RegisterBloC bloc;
  final getIt = GetIt.I;

  @override
  void initState() {
    bloc = getIt.get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: buildColumnWidgets(
              emailController, passwordController, bloc, context)),
    );
  }
}
