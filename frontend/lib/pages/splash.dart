import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    waitForServer();
  }

  void waitForServer() async {
    final url = Uri.parse('https://butex.onrender.com/api/v1/hello-world/all');
    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      Navigator.of(context).pushNamed('/signin');
    } else {
      showErrorPop();
    }
  }

  void showErrorPop() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Błąd połączenia'),
          content: Text(
              'Nie udało się połączyć z serwerem. Spróbuj ponownie później.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'WWJS',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: const Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'BUTEX',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30,
              ),
            ),
          ],
        )));
  }
}
