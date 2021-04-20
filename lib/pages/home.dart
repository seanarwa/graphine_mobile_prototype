import 'package:flutter/material.dart';
import 'package:graphine_mobile_prototype/api/firebase/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: Auth.signOut,
              icon: Icon(Icons.exit_to_app),
              label: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}


