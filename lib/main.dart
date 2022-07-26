import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User? currentUser = FirebaseAuth.instance.currentUser;

  if(currentUser!=null){
    runApp(const MyAppPage());
  }else{
    runApp(const MyAppLoggedIn());
  }
}

class MyAppPage extends StatelessWidget {
  const MyAppPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const HomePage(),
    );
  }
}

class MyAppLoggedIn extends StatelessWidget {
  const MyAppLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const LoginPage(),
    );
  }
}
