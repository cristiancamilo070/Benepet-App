import 'dart:async';
import 'package:benepet/src/bloc/auth_bloc.dart';
import 'package:benepet/src/pages/login/login_page.dart';
import 'package:benepet/src/utils/userHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomeAdminPage extends StatefulWidget {

  @override
  _HomeAdminPageState createState() => _HomeAdminPageState();

}

class _HomeAdminPageState extends State<HomeAdminPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin= false;
  StreamSubscription<User> loginStateSubscription;//cancelar el listener 

  checkAuthentification() async{
    _auth.authStateChanges().listen((user) { 
      if(user !=null){
        Navigator.pushNamed(context, 'home');
      }
      else{ Navigator.pushNamed(context, 'signup');}
    });
  }

  getUser() async{
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;
    if(firebaseUser !=null){
      setState(() {
        this.user =firebaseUser;
        this.isloggedin=true;
      });
    }
  }

  signOut()async{
    _auth.signOut();
  }

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final authBloc=Provider.of<AuthBloc>(context);
      return Scaffold(
        appBar: AppBar(
        title: Text('Admin Home'),
        ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          StreamBuilder(
              stream:FirebaseFirestore.instance.collection("Users").snapshots(),
              builder:(BuildContext context, 
              AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasData&&snapshot.data!=null) {
                final docs=snapshot.data.docs;
                  return ListView.builder(
                     shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final user = docs[index].data();                      
                      return ListTile(  
                        title: Text(user['name'] ?? user['email']),
                       // onTap: ,
                      );
                    },  
                  );
              }
              else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          },
       ),
      ElevatedButton(onPressed: (){signOut();}, child: Text("Log out"))
      ]
        ),
     )
    );
  }
}

// // class AdminHomePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Admin Home'),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: <Widget>[
// //             StreamBuilder(
// //               stream:
// //                   FirebaseFirestore.instance.collection("users").snapshots(),
// //               builder: (BuildContext context,
// //                   AsyncSnapshot<QuerySnapshot> snapshot) {
// //                 if (snapshot.hasData && snapshot.data != null) {
// //                   final docs = snapshot.data.docs;
// //                   return ListView.builder(
// //                     shrinkWrap: true,
// //                     physics: NeverScrollableScrollPhysics(),
// //                     itemCount: docs.length,
// //                     itemBuilder: (BuildContext context, int index) {
// //                       final user = docs[index].data();
// //                       return ListTile(
// //                         title: Text(user['name'] ?? user['email']),
// //                       );
// //                     },
// //                   );
// //                 } else {
// //                   return Center(
// //                     child: CircularProgressIndicator(),
// //                   );
// //                 }
// //               },
// //             ),
// //             RaisedButton(
// //               child: Text("Log out"),
// //               onPressed: () {
// //                 AuthHelper.logOut();
// //               },
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

//COPIAAAAAAAAAAAAA
//  return Scaffold(
    //     appBar: AppBar(
    //     title: Text('Admin Home'),
    //     ),
    //   body: Container(
    //     child: //!isloggedin? CircularProgressIndicator(): 
    //       StreamBuilder(
    //         stream:FirebaseFirestore.instance.collection("Users").snapshots(),
    //         builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
    //         if (!snapshot.hasData&&snapshot.data!=null) {
    //           final docs=snapshot.data.docs;
    //           return Container(
    //             width: 10,
    //             height: 12,
    //               child: ListView.builder(
    //               shrinkWrap: false,
    //               physics: NeverScrollableScrollPhysics(),
    //               itemCount: docs.length,
    //               itemBuilder:(BuildContext context,int index){
    //                 final user = docs[index].data();
    //                 return ListTile(title: Text(user['name']??user['email']),) ;
    //               },  
    //             ),
    //           );
    //         }
    //     },
    //    ),
    //  )
    // );