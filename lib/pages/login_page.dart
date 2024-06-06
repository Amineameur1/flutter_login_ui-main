import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'forgot_password_page.dart';
import 'profile_page.dart';
import 'widgets/header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
Future<void> login() async {
  if (_formKey.currentState?.validate() ?? false) {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final apiUrl = 'https://meltimanger-0c532dd4d091.herokuapp.com/login';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final nameclient = data['nameclient'];
          final message = data['message'];
   

        if ('Login successful.' == message ) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage(nameclient: nameclient)),
          );
        } else {
          _showErrorDialog('Invalid username or password');
        }
      } else {
        _showErrorDialog('Error fetching user data. Please try again later.');
      }
    } catch (e) {
      _showErrorDialog('An error occurred. Please try again.');
    }
  }
}


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Sign in to your account',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 30.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration: ThemeHelper().textInputDecoration('User Name', 'Enter your user name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: ThemeHelper().textInputDecoration('Password', 'Enter your password'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          onPressed: login,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Sign In'.toUpperCase(),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Sign Up screen
                    },
                    child: Text(
                      'Don\'t have an account? Create',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
