import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/access_cubit.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPass = TextEditingController();

  String name = '';
  String email = '';
  String password = '';
  bool passVisibility = true;

  @override
  void dispose() {
    controllerName.dispose();
    controllerEmail.dispose();
    controllerPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => moveToLogIn(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: screenHeight * 0.08),
              const Text(
                'Create Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const Text(

                'Lets Create Account Together',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: screenWidth * 0.075),
                  const Text(

                    'Your Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.11),
                      blurRadius: 40,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: TextField(
                  controller: controllerName,
                  onChanged: (String value) {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Tomek Kolanko',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 30),
                  Text(
                    'Email Address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.11),
                      blurRadius: 40,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: TextField(
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'name@mail.com',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 30),
                  Text(
                    'Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.11),
                      blurRadius: 40,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: TextField(
                  controller: controllerPass,
                  obscureText: passVisibility,
                  onChanged: (String value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passVisibility
                              ? passVisibility = false
                              : passVisibility = true;
                        });
                      },
                      icon: passVisibility
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined),
                    ),
                    hintText: 'password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                width: screenWidth * 0.8,
                height: screenHeight * 0.05,
                child: ElevatedButton(
                  onPressed: () =>
                      registerAccount(context, name, email, password),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already Have An Account?   ',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  GestureDetector(
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    onTap: () => moveToLogIn(context),

                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

registerAccount(
    BuildContext context, String name, String email, String password) {
  final pokeCubit = BlocProvider.of<AccessCubit>(context);
  pokeCubit.register(name, email, password);
}

moveToLogIn(BuildContext context) {
  final pokeCubit = BlocProvider.of<AccessCubit>(context);
  pokeCubit.moveToLog();
}
