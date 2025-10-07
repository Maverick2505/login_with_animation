import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Variable para controlar visibilidad de la contraseña
  bool _isPasswordVisible = false;

  StateMachineController? controller;
  //Logica de animaciones
  //smi state machine input
  SMIBool? isChecking;//modo chismoso
  SMIBool? isHandsUp;//se tapa los ojos
  SMIBool? trigSuccess;//Se emociona
  SMIBool? trigFail;//Se achicopala

  //1)FocusNode
  final emailFocus = FocusNode();
  final passFocus= FocusNode();

  //2)Listeners (Oyentes)
  @override
  void initState() {
    super.initState();
    emailFocus.addListener((){
      if (emailFocus.hasFocus){
      //manos abajo en email
      isHandsUp?.change(false);
      }
    });
    passFocus.addListener((){
      isHandsUp?.change(passFocus.hasFocus);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  "assets/animated_login_character.riv",
                  stateMachines: ["Login Machine"],
                  //Al iniciarse
                  onInit: (artboard){
                    controller= StateMachineController.fromArtboard(
                      artboard, 
                      "Login Machine",
                    );
                    //Verificar que inicio bien
                    if (controller == null) return;
                    artboard.addController(controller!);
                    isChecking = controller!.findSMI("isChecking");
                    isHandsUp = controller!.findSMI("isHandsUp");
                    trigSuccess = controller!.findSMI("trigSuccess");
                    trigFail = controller!.findSMI("trigFail");
                  }
                  ),
              ),
              const SizedBox(height: 10),
              // Campo de texto del email
              TextField(
                focusNode: emailFocus,
                onChanged: (value) {
                  if (isHandsUp != null){
                    //no tapar los ojos al escribir email
                    isHandsUp!.change(false);
                  }
                  if (isChecking == null) return;
                  // modo chismoso activado
                  isChecking!.change(true);
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email brou",
                  prefixIcon: const Icon(Icons.mail),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Campo de texto de la contraseña
              TextField(
                focusNode: passFocus,
                onChanged: (value) {
                  if (isChecking != null){
                    //no tapar los ojos al escribir email
                    isChecking!.change(false);
                  }
                  if (isHandsUp == null) return;
                  // modo chismoso activado
                  isHandsUp!.change(true);
                  },
                
                obscureText: !_isPasswordVisible, // alterna visibilidad
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // Botón del ojo para mostrar/ocultar
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width,
                child: const Text(
                  "Forgot your password?",
                  textAlign: TextAlign.right,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              //Boton de loging
              const SizedBox(height: 10),
            MaterialButton(
              minWidth: size.width,
              height: 50,
              color: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              onPressed: (){},
              child: Text(
                "Loging",
                style: TextStyle(
                  color: Colors.white),),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dont have an account?"),
                    TextButton(
                      onPressed: (){}, 
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      )
                   )
                  ],),
              )
            ],
          ),
        ),
      ),
    );
  }
@override
void dispose(){
  emailFocus.dispose();
  passFocus.dispose();
  super.dispose();
  }
}
