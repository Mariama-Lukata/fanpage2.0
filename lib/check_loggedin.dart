import 'package:fanpage2/home.dart';
import 'package:fanpage2/signup.dart';
import 'package:flutter/material.dart';

class checked extends StatelessWidget {
  const checked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            
            return home();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Something Went Wrong!'),
            );
          } else {
            return SignUpScreen();
          }
        },
      ),
    );
  }
}
