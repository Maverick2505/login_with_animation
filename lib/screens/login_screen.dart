import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        //Evita nudge o camaras no me acuerdo
        child: Column(
          children: [
            Expanded(
              child: RiveAnimation.asset("assets/animated_login_character.riv"))
          ],
        ),
      ),
    );
  }
}