import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lojaapp/features/login/presentation/controllers/login_bloc.dart';
import 'package:lojaapp/features/login/presentation/controllers/login_event.dart';
import 'package:lojaapp/features/login/presentation/widgets/build_column_widgets.dart';
import 'package:lojaapp/features/register/presentation/controllers/register_bloc.dart';
import 'package:lojaapp/main.dart';

import '../../../register/presentation/widgets/build_column_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Center(
          child: buildColumnWidgetsLoginScreen(
              width, context, bloc, emailController, passwordController)),
    );
  }
}
