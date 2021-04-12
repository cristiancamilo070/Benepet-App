import 'dart:async';
import 'package:benepet/src/bloc/auth_bloc.dart';
import 'package:benepet/src/pages/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

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
    }
    );
    super.initState();
  }


  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc=Provider.of<AuthBloc>(context);
      return Scaffold(
      body: Container(
        child: //!isloggedin? CircularProgressIndicator(): 
          StreamBuilder<User>(
            stream:authBloc.currentUser,
            builder:(context,snapshot){
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }else{
            return Column(
          children: <Widget>[
            SizedBox(height: 40.0),
            Container(
            height: 300,
            ),     
            Container(
              child: Text("Hello ${snapshot.data.displayName} you are Logged in as ${snapshot.data.email}",
              //child: Text("Hello } you are Logged in as",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),),
            ),

            // ignore: deprecated_member_use
            RaisedButton(
              padding: EdgeInsets.fromLTRB(70,10,70,10),
             
              onPressed: ()=>authBloc.logout(),//signOut,
             
              child: Text('Signout',style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold
              )
              ),

              color: Colors.orange,
              shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.circular(20.0),
              ),
            )
          ],
        );
        }
        },
       ),
     )
    );
  }
}