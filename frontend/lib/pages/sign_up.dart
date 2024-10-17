import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController controllerName = TextEditingController();
  late TextEditingController controllerEmail = TextEditingController();
  late TextEditingController controllerPass = TextEditingController();
  String name = '';
  String email = '';
  String password = '';
  bool passVisibilty = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controllerName.dispose();
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
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new))),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
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
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 30),
                Text(
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
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.11),
                  blurRadius: 40,
                  spreadRadius: 0.0,
                )
              ]),
              child: TextField(
                controller: controllerName,
                onChanged: (String value) {
                  setState(() {
                    name = controllerEmail.text;
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Tomek Kolanko',
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
                controller: controllerEmail,
                onChanged: (String value) {
                  setState(() {
                    email = controllerEmail.text;
                  });
                },
                keyboardType: TextInputType.emailAddress,
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
                    password = controllerEmail.text;
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
                        icon: const Icon(Icons.visibility_outlined)),
                    hintText: 'password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none)),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                width: 350,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      print('Name: $name, Email: $email, Pass: $password');
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ))),
            const SizedBox(height: 130),
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
                  onTap: () {
                    Navigator.pop(context);
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
