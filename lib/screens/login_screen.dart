import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
// 3.1 Importar librería para timer
import "dart:async";

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
  //2.1 Variable para recorrido de la mirada
  SMINumber? numLook;

  //1)FocusNode
  final emailFocus = FocusNode();
  final passFocus= FocusNode();
  //Crear variable timer para detener la mirada al dejar de teclear
  Timer? _typingDebounce;

  //2)Listeners (Oyentes)
  @override
  void initState() {
    super.initState();
    emailFocus.addListener((){
      if (emailFocus.hasFocus){
      //manos abajo en email
      isHandsUp?.change(false);
      //2.2 mirada neutral al enfocar el email
      numLook?.value = 50.0;
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
                    numLook = controller!.findSMI("numLook");
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
                    //ajuste de limites de 0  100
                    //80 es una medida de calibración 
                    final look = (value.length / 80.0 * 100.0).clamp(0.0, 100.0);
                    numLook?.value = look;

                    //3.3 Si vuelve a teclear, reinicia el contador
                    _typingDebounce?.cancel();//cancela cualquier timer existente
                    _typingDebounce = Timer(const Duration(seconds: 3),(){
                      if (!mounted) {
                        return; //Si la pantalla se cierra
                      }
                      //mirada neutral
                      isChecking?.change(false);
                    });
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
  _typingDebounce?.cancel();
  super.dispose();
  }
}
