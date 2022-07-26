import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:immence/login_page.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:immence/profile_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80,),
                Text(
                  '  immence',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30,),
                const Text(
                  '   Users',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(snapshot.hasData){
                      final snap = snapshot.data!.docs;
                      return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: snap.length,
                          itemBuilder: (context , index){
                            return SizedBox(
                              height: 65,
                              child: Card(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      child: const Text('V'),
                                      backgroundColor: Colors.blue[50],
                                    ),
                                    SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('${snap[index]['fullName']}'),
                                        Text('${snap[index]['email']}'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    }else{
                      return SizedBox();
                    }
                  },
                ),
              ],
            )
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
                        Get.to(const ProfilePage());
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
