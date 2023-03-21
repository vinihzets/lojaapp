import 'package:flutter/material.dart';
import 'package:lojaapp/features/login/presentation/bloc/login_bloc.dart';

import '../bloc/login_event.dart';

Widget buildColumnWidgetsLoginScreen(
    double width,
    BuildContext context,
    LoginBloc bloc,
    TextEditingController emailController,
    TextEditingController passwordController) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: (width / 2) * 1.2,
        child: TextField(
          controller: emailController,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
              hintText: 'e-mail',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)))),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: (width / 2) * 1.2,
        child: TextField(
          obscureText: true,
          controller: passwordController,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
              hintText: 'password',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)))),
        ),
      ),
      TextButton(
          onPressed: () {},
          child: const Text('Esqueci Minha Senha',
              style: TextStyle(color: Colors.blue))),
      SizedBox(
        width: 240,
        child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blue)),
          onPressed: () => bloc.event.add(LoginEventSignIn(
              context, emailController.text, passwordController.text)),
          child: const Text('login'),
        ),
      ),
    ],
  );
}
