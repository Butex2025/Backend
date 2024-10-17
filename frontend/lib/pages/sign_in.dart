import 'package:flutter/material.dart';
import 'package:frontend/pages/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController controllerEmail = TextEditingController();
  late TextEditingController controllerPass = TextEditingController();
  String email = '';
  String password = '';
  bool passVisibilty = true;

  @override
  void initState() {
    super.initState();
  }

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
            child: IconButton(
                onPressed: () {
                  //Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new))),
      ),
      body: Center(
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
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.11),
                  blurRadius: 40,
                  spreadRadius: 0.0,
                )
              ]),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: controllerEmail,
                onChanged: (String value) {
                  setState(() {
                    email = controllerEmail.text;
                  });
                },
                decoration: InputDecoration(
                    hintText: 'name@mail.com',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none)),
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
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.11),
                  blurRadius: 40,
                  spreadRadius: 0.0,
                )
              ]),
              child: TextField(
                controller: controllerPass,
                onChanged: (String value) {
                  setState(() {
                    password = controllerPass.text;
                  });
                },
                obscureText: passVisibilty,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passVisibilty
                                ? passVisibilty = false
                                : passVisibilty = true;
                          });
                        },
                        icon: (passVisibilty
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined))),
                    hintText: 'password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none)),
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
                    onPressed: () {
                      print('Email: $email Password: $password');
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ))),
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
