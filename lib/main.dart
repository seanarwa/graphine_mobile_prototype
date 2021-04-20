import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphine_mobile_prototype/api/firebase/auth.dart';
import 'package:graphine_mobile_prototype/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

class App extends StatelessWidget {
  App() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Auth.state.listen((user) {
        if (user == null) {
          Get.offAllNamed(LoginPage.routeName);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Graphine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme(
            elevation: 8.0
        ),
        textTheme: TextTheme(
          headline1: GoogleFonts.montserrat(color: Colors.black),
          headline2: GoogleFonts.montserrat(color: Colors.black),
          headline3: GoogleFonts.montserrat(color: Colors.black),
          headline4: GoogleFonts.montserrat(color: Colors.black),
          headline5: GoogleFonts.montserrat(color: Colors.black),
          headline6: GoogleFonts.montserrat(color: Colors.black),
          subtitle1: GoogleFonts.montserrat(color: Colors.black),
          subtitle2: GoogleFonts.montserrat(color: Colors.black54),
          bodyText1: GoogleFonts.montserrat(color: Colors.black),
          bodyText2: GoogleFonts.montserrat(color: Colors.black),
          caption: GoogleFonts.montserrat(color: Colors.black54),
          button: GoogleFonts.montserrat(color: Colors.black),
          overline: GoogleFonts.montserrat(color: Colors.black),
        ),
      ),
      initialRoute: Auth.isSignedIn() ? '/' : '/login',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/scanner', page: () => ScannerPage()),
      ],
    );
  }
}
