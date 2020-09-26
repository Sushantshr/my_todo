import 'package:flutter/material.dart';
import 'package:my_todo/screens/home_screen.dart';
import 'package:my_todo/services/AuthService.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _email,
          decoration: InputDecoration(
            // enabledBorder: const OutlineInputBorder(
            //   borderSide: const BorderSide(color: Colors.white),
            // ),
            hintText: "Email",
            // hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: _password,
          obscureText: true,
          decoration: InputDecoration(
            // enabledBorder: const OutlineInputBorder(
            //   borderSide: const BorderSide(color: Colors.white),
            // ),
            hintText: "Password",
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25),
          width: double.infinity,
          child: RaisedButton(
            color: Colors.white,
            elevation: 5,
            padding: const EdgeInsets.all(15),
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              var user = await AuthService.loginWithEmail(
                  email: email, password: password);

              print(user);
              if (user != null) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (contect) {
                  return HomeScreen();
                }));
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              // side: BorderSide(color: Colors.orange),
            ),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF527DAA),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
