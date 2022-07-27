import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:immence/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_page.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String currentFullName ='';
  String currentPhoneNumber='';
  String currentEmail='';

  _fetch() async {
    final fbCurrentUser = FirebaseAuth.instance.currentUser;
    if (fbCurrentUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(fbCurrentUser.uid)
          .get()
          .then((ds) {
        currentFullName = ds.get('fullName');
        currentPhoneNumber = ds.get('phoneNumber');
        currentEmail = ds.get('email');
      }).catchError((e) {
        log(e);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder(
              future: _fetch(),
              builder: (context,snapshot){

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Image.asset('assets/image/immence.png',),
                      radius: 60,
                      backgroundColor: Colors.blue[50],
                    ),
                    const SizedBox(height: 10,),
                    Text(currentFullName.toString()),
                    const SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Email'),
                        Text(currentEmail.toString()),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Phone Number'),
                        Text(currentPhoneNumber.toString()),
                      ],
                    ), const SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Log Out'),
                        IconButton(onPressed: ()async{
                          await FirebaseAuth.instance.signOut();
                          Get.offAll(const ProfilePage());
                          Get.to(const LoginPage());
                        },
                            icon:const Icon(Icons.logout))
                      ],
                    )
                  ],
                );
              }),
        ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.to(const HomePage());
                      },
                      icon:const Icon(
                        Icons.person_add,
                        color: Colors.black,
                        size: 30,
                      )
                  ),
                  const Text('users',style: TextStyle(color: Colors.black,fontSize: 12),),
                  const SizedBox(height: 2,)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.to(ProfilePage());
                      },
                      icon:const Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 30,
                      )
                  ),
                  const Text('profile',style: TextStyle(color: Colors.black,fontSize: 12),),
                  const SizedBox(height: 2,)
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
