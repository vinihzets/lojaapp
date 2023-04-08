import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../bloc/login_bloc.dart';
import '../widgets/build_column_widgets.dart';

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
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Entrar'),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () => bloc.onPressedNavigate(context),
                child: const Text(
                  'Criar Conta',
                  style: TextStyle(color: Colors.white),
                )),
          ]),
      body: Center(
          child: buildColumnWidgetsLoginScreen(
              width, context, bloc, emailController, passwordController)),
    );
  }
}
