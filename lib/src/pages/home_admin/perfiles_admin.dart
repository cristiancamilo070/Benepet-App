import 'package:benepet/src/widgets/home_bg.dart';
import 'package:benepet/src/widgets/menu_admin_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class PerfilesAdmin extends StatefulWidget {
  @override
  _PerfilesAdminState createState() => _PerfilesAdminState();
}

class _PerfilesAdminState extends State<PerfilesAdmin> {
  
  //COLORES--------------------
  final Color primario=Color(0XFF364f6b);
  final Color secundario=Color(0XFF3fc1c9);
  final Color terciario=Color(0XFFfc5185);
  final Color background=Color(0XFFf5f5f5);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Perfiles registrados'),
      backgroundColor: secundario
      ),
      drawer: MenuAdminWidget(),
      body: Container(
        child: HomeBackground(
          child: SingleChildScrollView(
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
            ElevatedButton(
              onPressed: (){
                
              }
              , child: Text("Log out")
              )
            ]
          ),
        ),
      ),
    )
  );
  }
}