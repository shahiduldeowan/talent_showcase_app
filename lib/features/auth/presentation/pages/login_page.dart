import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Login Page'),
            ElevatedButton(
              onPressed: () {
                // Handle login action
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
