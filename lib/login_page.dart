import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:immence/home_page.dart';
import 'package:immence/signup_page.dart';
import 'package:immence/ui_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void checkValues(){
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if(email == '' || password == '' ){
      UIHelper.showAlertDialod(context, 'Incomplete Data', 'please fill all the field!');

    }else{
      logIn(email, password);
    }
  }
  void logIn(String email,String password) async{
    UserCredential? credetial;
    UIHelper.showLoadingDialog(context, 'Logging In...');
    try{
      credetial = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(ex){
      Navigator.pop(context);
      UIHelper.showAlertDialod(context,'An error occurred', ex.message.toString());
    }
    if(credetial != null){
      Get.to(const HomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 30,),
                Text(
                  'Immence',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30,),
                const Text(
                  'Hi, Welcome Back!',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 30,),
                const Text('Email'),
                const SizedBox(height: 5,),
                SizedBox(
                  height: 41,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'enter the email',
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                const Text('Password'),
                const SizedBox(height: 5,),
                SizedBox(
                  height: 41,
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'enter the password',
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CupertinoButton(
                      onPressed:checkValues,
                      color: Theme.of(context).colorScheme.secondary,
                      child: const Text('Log In'),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Don\'t have an account?',
            style: TextStyle(
              fontSize: 16,
            ), ),
          CupertinoButton(
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 16,
              ),
            ),
            onPressed: (){
              Get.to(const SignupPage());
            },
          ),
        ],
      ),
    );
  }
}


