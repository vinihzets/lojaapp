import 'package:flutter/material.dart';
import 'package:lojaapp/features/register/presentation/controllers/register_bloc.dart';
import 'package:lojaapp/features/register/presentation/controllers/register_event.dart';
import 'package:lojaapp/main.dart';

Widget buildColumnWidgets(TextEditingController emailController,
    TextEditingController passwordController, RegisterBloC bloc, context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
          width: 260,
          child: TextField(
            controller: emailController,
            decoration: const InputDecoration(
                hintText: 'e-mail',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
          )),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            width: 260,
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            )),
      ),
      ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.grey)),
          onPressed: () => bloc.event.add(RegisterEventSignUp(
              email: emailController.text,
              password: passwordController.text,
              context: context)),
          child: const Text('Register')),
      TextButton(
          onPressed: () => bloc.onNavigatePop(context),
          child: const Text(
            'Login',
            style: TextStyle(color: Colors.grey),
          ))
    ],
  );
}
