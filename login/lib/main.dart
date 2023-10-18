import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Initialize Firebase and add plugins
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

//Initialize Firebase Realtime Database
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = database.ref();


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

Future<bool> isLoginSuccessful(String login, String pass) async{
  String token = "";//Retrieve token

  try {
    final userCredential =
        await FirebaseAuth.instance.signInWithCustomToken(token);
    print("Sign-in successful.");
    return true;
} on FirebaseAuthException catch (e) {
    switch (e.code) {
        case "invalid-custom-token":
            print("The supplied token is not a Firebase custom auth token.");
            break;
        case "custom-token-mismatch":
            print("The supplied token is for a different Firebase project.");
            break;
        default:
            print("Unkown error.");
    }
    return false;
}

}