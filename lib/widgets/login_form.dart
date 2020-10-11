import 'package:flutter/material.dart';
import 'package:my_todo/services/auth_service.dart';

class LoginForm extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;

  LoginForm({Key key, this.scaffoldKey}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _hidePassword = true;

  void _toggle() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

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
          obscureText: _hidePassword,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: _toggle,
              child: Icon(
                Icons.remove_red_eye,
                color: _hidePassword ? Colors.grey : Colors.red,
              ),
            ),
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

              var snackBar;
              if (user != null) {
                snackBar = SnackBar(
                  content: Text("Successfully Logged In"),
                );
              } else {
                snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("Some error occured, please try again."),
                );
              }
              widget.scaffoldKey.currentState.showSnackBar(snackBar);
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
