import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:immence/home_page.dart';
import 'package:immence/login_page.dart';
import 'package:immence/ui_helper.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  State<SignupPage> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  File? imageFile;
  User? firebaseuser = FirebaseAuth.instance.currentUser;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController   phoneNumberController = TextEditingController();

  Future<void> addData(data) async {

    FirebaseFirestore.instance.collection("users").add(data).catchError((e) {
      print(e);
    });
  }

  void checkValues(){
    String fullName = fullNameController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String email =emailController.text.trim();

    if(fullName =='' || imageFile==null || phoneNumber =='' || email == '' ){
      UIHelper.showAlertDialod(context, 'Incomplete Data','please fill all the fields and upload the profile picture');

    }else{
      uploadData();
    }
  }
  void uploadData() async{
    String? fullName = fullNameController.text.trim();
    String? phoneNumber = phoneNumberController.text.trim();
    String? email =emailController.text.trim();
    String uid = FirebaseAuth.instance.currentUser!.uid;

    Map<String, dynamic> blogData = {
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "email": email,
    };

    addData(blogData).then((value){
      log('Data Uploaded!');
      Get.off(const SignupPage());
      Get.to(const HomePage());
    });

  }

  void checkValue(){
    String email = emailController.text.trim();
    String fullName =fullNameController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String password = passwordController.text.trim();

    if(email == '' || password=='' || fullName == '' || phoneNumber==''){
      UIHelper.showAlertDialod(context, 'Incomplete Data', 'please fills all the fields!');
    }else{
      signUp(email, password, fullName, phoneNumber);
    }
  }

  void signUp(String email, String password, String fullName, String phoneNumber) async{
    UserCredential? credential;
    UIHelper.showLoadingDialog(context, 'Create a new account');
    try{
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(ex){
      Navigator.pop(context);
      UIHelper.showAlertDialod(context, 'An error accrued', ex.code.toString());
    }
    if(credential!=null){
      uploadData();
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
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Immence',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    'Create an account',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text('Name'),
                  const SizedBox(height: 5,),
                  SizedBox(
                    height: 41,
                    child: TextField(
                      controller: fullNameController,
                      decoration: InputDecoration(

                        labelText: 'Full Name',
                        hintText: 'enter the name',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),

                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
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
                  const Text('Phone Number'),
                  const SizedBox(height: 5,),
                  SizedBox(
                    height: 41,
                    child: TextField(
                      controller: phoneNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(

                        labelText: 'Phone Number',
                        hintText: 'enter the phone Number',
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
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Checkbox(
                          value: true,
                          onChanged: (value){

                          },
                      ),
                      const Text('Remember Me'),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CupertinoButton(
                        onPressed: checkValue,
                        color: Theme.of(context).colorScheme.secondary,
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Already have an account?',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          CupertinoButton(
            child: Text(
              'Sign In',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 16,
              ),
            ),
            onPressed: (){
              Get.off(const SignupPage());
              Get.to(const LoginPage());
            },
          ),
        ],
      ),
    );
  }
}


