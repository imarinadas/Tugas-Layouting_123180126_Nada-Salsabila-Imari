import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  String email = "";
  String password = "";
  FormType form = FormType.login;
  bool isLoginSuccess = false;

  _LoginPageState() {
    emailController.addListener(emailListen);
    passwordController.addListener(passwordListen);
  }

  void emailListen() {
    if (emailController.text.isEmpty) {
      email = "";
    } else {
      email = emailController.text;
    }
  }

  void passwordListen() {
    if (passwordController.text.isEmpty) {
      password = "";
    } else {
      password = passwordController.text;
    }
  }

  void _formChange () async {
    setState(() {
      if (form == FormType.register) {
        form = FormType.login;
      } else {
        form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
        ),
        body: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Column(
            children: <Widget>[
              _logoField(),
              _emailField(),
              _passwordField(),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoField() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 50.0,
        height: 70.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            image: DecorationImage(
                image: NetworkImage(
                  "data:image/png;base64,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",
                ), fit: BoxFit.cover)
        ),
      ),
    );
  }

  Widget _emailField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: new TextField(
        enabled: true,
        controller: emailController,
        onChanged: (value) {
          email = value;
        },
        decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: const EdgeInsets.all(8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
                color: (isLoginSuccess) ? Colors.blue : Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        enabled: true,
        controller: passwordController,
        obscureText: true,
        onChanged: (value) {
          password = value;
        },
        decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: const EdgeInsets.all(8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
                color: (isLoginSuccess) ? Colors.blue : Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    if (form == FormType.login) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: (isLoginSuccess) ? Colors.blue : Colors.red, // background
                onPrimary: Colors.white, // foreground
              ),

              onPressed: () {
                _loginPressed();
                String text = "";
                if (email == "nama@email.com" && password == "password123") {
                  setState(() {
                    text = "Login Success";
                    isLoginSuccess = true;
                  });
                } else {
                  setState(() {
                    text = "Login Failed";
                    isLoginSuccess = false;
                  });
                }

                print("isLoginSuccess : $isLoginSuccess");

                SnackBar snackBar = SnackBar(
                  content: Text(text),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: new Text('Login'),
            ),
            new FlatButton(
              child: new Text('Dont have an account? Tap here to register.'),
              onPressed: _formChange,
            ),
            new FlatButton(
              child: new Text('Forgot Password?'),
              onPressed: _passwordReset,
            )
          ],
        ),
      );
    } else {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Create an Account'),
              onPressed: _createAccountPressed,
            ),
            new FlatButton(
              child: new Text('Have an account? Click here to login.'),
              onPressed: _formChange,
            )
          ],
        ),
      );
    }
  }

  void _loginPressed () {
    print('The user wants to login with $email and $password');
  }

  void _createAccountPressed () {
    print('The user wants to create an accoutn with $email and $password');

  }

  void _passwordReset () {
    print("The user wants a password reset request sent to $email");
  }


}