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
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: (width / 2) * 1.2,
          child: TextField(
            obscureText: true,
            controller: passwordController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                hintText: 'password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
          ),
        ),
      ),
      ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.grey)),
        onPressed: () => bloc.event.add(LoginEventSignIn(
            context, emailController.text, passwordController.text)),
        child: const Text('login'),
      ),
      TextButton(
          onPressed: () => bloc.onPressedNavigate(context),
          child:
              const Text('registre-se', style: TextStyle(color: Colors.grey)))
    ],
  );
}
