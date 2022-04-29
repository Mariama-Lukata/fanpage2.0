
import 'package:connectivity/connectivity.dart';
import 'package:fanpage2/google_sign_in.dart';
import 'package:fanpage2/home.dart';
import 'package:fanpage2/reused.dart';
import 'package:fanpage2/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Welcom to FanPage"),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
         
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                60, MediaQuery.of(context).size.height * .1, 50, 0),

            child: Column(
              children: <Widget>[
               ElevatedButton.icon(style: ElevatedButton.styleFrom(
               primary: Colors.white,
               onPrimary: Colors.blue,
               minimumSize: Size(double.infinity, 30)
             ),icon: FaIcon(FontAwesomeIcons.google, color: Colors.blue,),
             onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
             }, label: Text("Sign Up With Google")),

                SizedBox(
                  height: 30,
                ),
                reusableTextField("user@email.com", Icons.person_outline, false,
                    _emailTextController),
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Password 6+ )", Icons.lock_outline, true,
                    _passwordTextController),
                SizedBox(
                  height: 30,
                ),
                signInSignUpButton(context, true, () {
                  if (_emailTextController.text.isEmpty ||
                      _passwordTextController.text.isEmpty) {
                    createAlertDialog(context, "Empty (one or more)");
                  }
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) => {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => home()))
                          })
                      .onError((error, stackTrace) {
                    return createAlertDialog(context,
                        "Incorrect, Email must be in proper format,Passwords must be at least 6 characters");
                  });
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
