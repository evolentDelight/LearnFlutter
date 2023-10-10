import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Login Page')),
        body: const LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget{
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController loginController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        TextFormField(
          controller: loginController,
          decoration: const InputDecoration(
            labelText: "Login",
            hintText: "ID",
          ),
          validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
        ),
        Padding(padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: (){
              if(_formKey.currentState!.validate())
                print("Submitted: ${loginController.text}");
              },
              child: const Text('Submit'),
            )
          )
      ],)
    );
  }
}