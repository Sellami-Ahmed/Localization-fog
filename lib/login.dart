import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  void _login() {
    // Implement your login logic here
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Add your authentication logic, for example, comparing the username and password with a database.
    if (username == 'user' && password == 'password') {
      // Successful login, navigate to another page.
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>
              HomePage(name: _usernameController.text.toString()),
        ),
        (route) => false, //if you want to disable back feature set to false
      );
    } else {
      // Show an error message if login fails.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Please check your credentials.'),
        ),
      );
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
