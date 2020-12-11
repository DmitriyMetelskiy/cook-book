import 'package:flutter/material.dart';
import 'package:cook_book/ui/widgets/google_sign_in_button.dart';

import '../../state_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Text _buildText() {
      return Text(
        'Cook Book',
        style: Theme.of(context).textTheme.headline4,
        textAlign: TextAlign.center,
      );
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login.jpg"),
            fit:BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildText(),
              // Space between "Recipes" and the button:
              SizedBox(height: 40.0),
              GoogleSignInButton(
                onPressed: () => StateWidget.of(context).signInWithGoogle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}