import 'package:flutter/material.dart';
import 'package:lojaapp/main.dart';

class InitializeBloc {
  onNavigate(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      gConsts.loginScreen,
      (route) => false,
    );
  }
}
