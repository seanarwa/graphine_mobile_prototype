import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:graphine_mobile_prototype/api/firebase/auth.dart';
import 'package:graphine_mobile_prototype/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  AnimationController _animationController1;
  AnimationController _animationController2;
  CurvedAnimation _animation1;
  CurvedAnimation _animation2;

  @override
  void initState() {
    super.initState();
    _animationController1 = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    _animationController2 = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);
    _animation1 = CurvedAnimation(parent: _animationController1, curve: Curves.easeIn);
    _animation2 = CurvedAnimation(parent: _animationController2, curve: Curves.easeIn);

    Auth.state.listen((user) {
      if (user != null) {
        Get.to(HomePage(), transition: Transition.fadeIn);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animate();
    });
  }


  @override
  void dispose() {
    _animationController1.dispose();
    _animationController2.dispose();
    super.dispose();
  }

  void _animate() async {
    _animationController1.forward();
    await Future.delayed(Duration(milliseconds: 500));
    _animationController2.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeTransition(
              opacity: _animation1,
              child: Column(
                children: [
                  Image.asset(
                    'images/app_icon.png',
                    width: 150,
                    height: 150,
                  ),
                  Text(
                    'Graphine',
                    style: TextStyle(
                      color: Colors.orange[800],
                      fontSize: 56.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
            FadeTransition(
              opacity: _animation2,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      SignInButton(
                        Buttons.GoogleDark,
                        onPressed: Auth.googleSignIn,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
