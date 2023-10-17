import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localization_client/api.dart';
import 'package:localization_client/geolocator.dart';
import 'package:localization_client/signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

void _navigateToSignup(BuildContext context) {
  // Navigate to the signup page.
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SignupPage()));
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    // Implement your login logic here
    String username = _usernameController.text;
    String password = _passwordController.text;

    var response = await signIn(username, password);

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      if (responseJson != null) {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => HomePage(
              name: username,
              id: responseJson["id"],
            ),
          ),
          (route) => false, //if you want to disable back feature set to false
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Login failed. Please check your credentials.')));
      }
    } else {
      throw Exception('uncorrect login information');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                ),
                ElevatedButton(
                    onPressed: () => _navigateToSignup(context),
                    child: Text("sign up"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
