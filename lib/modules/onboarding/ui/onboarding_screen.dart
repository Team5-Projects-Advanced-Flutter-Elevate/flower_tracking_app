import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hello")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: Text("Login")),
            FilledButton(onPressed: () {}, child: Text("Test")),
            OutlinedButton(onPressed: () {}, child: Text("Test")),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
