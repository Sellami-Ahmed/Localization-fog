import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization_client/geolocator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F9D58),
        title: Text("Login"),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _fullNameController,
              validator: (val) => val!.isEmpty ? "could not be empty" : null,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                prefixIcon: Icon(Icons.account_circle),
                border: OutlineInputBorder(),
                hintText: "userName",
                labelText: "userName",
              ),
            ),
          ),
          CupertinoButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              onSave(context);
            },
            child: const Text("enter"),
          )
        ],
      ),
    );
  }

  onSave(BuildContext context) {
    bool allValid = true;
    //If any form validation function returns false means all forms are not valid

    allValid = validate();

    if (allValid) {
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>
              HomePage(name: _fullNameController.text.toString()),
        ),
        (route) => false, //if you want to disable back feature set to false
      );
    } else {
      debugPrint("Form is Not Valid");
    }
  }

  bool validate() {
    //Validate Form Fields by form key
    bool validate = _formKey.currentState!.validate();
    return validate;
  }
}
