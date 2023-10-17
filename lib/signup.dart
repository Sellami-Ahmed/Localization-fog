// signup.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localization_client/api.dart';
import 'package:localization_client/login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _newUsernameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _passwordErrorText = '';

  void _signup() async {
    // Implement your signup logic here
    String newUsername = _newUsernameController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Check if the password and confirm password match.
    if (newPassword == confirmPassword) {
      // Passwords match, proceed with signup.
      _passwordErrorText = '';
      var response = await signUp(newUsername, newPassword);
      print(response.statusCode);
      if (response.statusCode == 201) {
        final responseJson = jsonDecode(response.body);
        if (responseJson != null) {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => LoginPage(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Account Created')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Login failed. Please check your credentials.')));
        }
      } else {
        throw Exception('uncorrect login information');
      }

      // Add your registration logic, for example, storing the user's information in a database.

      // After successful signup, you might navigate to a login page or the home screen.
    } else {
      // Passwords do not match, display an error message.
      _passwordErrorText = 'Passwords do not match.';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _newUsernameController,
                decoration: InputDecoration(
                  labelText: 'New Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  errorText: _passwordErrorText,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _signup,
              child: Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
