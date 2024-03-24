import 'package:blog_app/features/auth/presentation/widget/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widget/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign Up.",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            AuthField(hintText: "Name"),
            SizedBox(
              height: 15,
            ),
            AuthField(hintText: "Email"),
            SizedBox(
              height: 15,
            ),
            AuthField(hintText: "Password"),
            SizedBox(
              height: 15,
            ),
            AuthGradientButton()
          ],
        ),
      ),
    );
  }
}
