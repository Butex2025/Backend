import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/access_cubit.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPass = TextEditingController();

  String email = '';
  String password = '';
  bool passVisibility = true;

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          alignment: Alignment.center,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80),
              const Text(
                'Hello Again!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const Text(
                'Welcome Back Youve Been Missed!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 60),
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
                  keyboardType: TextInputType.emailAddress,
                  controller: controllerEmail,
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
              const SizedBox(height: 30),
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
                  onChanged: (String value) {
                    setState(() {
                      password = value;
                    });
                  },
                  obscureText: passVisibility,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passVisibility = !passVisibility;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: const Text('Recovery Password'),
                    onTap: () {},
                  ),
                  const SizedBox(width: 30),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                width: 350,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => logIn(context, email, password),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Dont Have An Account?   ',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  GestureDetector(
                    child: const Text(
                      'Sign Up For Free',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    onTap: () => moveToRegister(context),
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

logIn(BuildContext context, String email, String password) {
  final pokeCubit = BlocProvider.of<AccessCubit>(context);
  pokeCubit.logIn(email, password);
}

moveToRegister(BuildContext context) {
  final pokeCubit = BlocProvider.of<AccessCubit>(context);
  pokeCubit.moveToRegister();
}
