import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:package_info/package_info.dart';

class UserHelper{

  static FirebaseFirestore _db =FirebaseFirestore.instance;

  static saveUser(User user,String nombreCompleto )async{
    PackageInfo packageInfo=await PackageInfo.fromPlatform();
    int buildNumber= int.parse(packageInfo.buildNumber);

    Map<String,dynamic> userData={
      "name": nombreCompleto,
      "email":user.email,
      "last_login":user.metadata.lastSignInTime.day,
      "created_at":user.metadata.creationTime.millisecondsSinceEpoch,
      "role":"user",
    };

  final userRef =_db.collection("Users").doc(user.email);//uid o email

  if ((await userRef.get()).exists) {
    await userRef.update({
      "last_login":user.metadata.lastSignInTime.day,
    });
    }
    else{
      await userRef.set(userData);
    }
    await _saveDevice(user);
  }


  static _saveDevice(User user) async{
    DeviceInfoPlugin deviceInfoPlugin=DeviceInfoPlugin();
    String deviceId;
    String modelo;
    String plataforma;
    Map<String,dynamic>deviceData;
    if (Platform.isAndroid) {
      final deviceInfo=await deviceInfoPlugin.androidInfo;
      deviceId=deviceInfo.androidId;
      // deviceData={
      // "device":deviceInfo.device
      // };
      plataforma="Android";
      modelo=deviceInfo.model;
    }
    if (Platform.isIOS) {
      final deviceInfo=await deviceInfoPlugin.iosInfo;
      deviceId=deviceInfo.identifierForVendor;
      // deviceData={
      // "device":deviceInfo.name
      // };
      plataforma="Ios";
      modelo=deviceInfo.model;
    }
    final nowMs=DateTime.now().millisecondsSinceEpoch;

    final deviceRef=_db.collection("Users").doc(user.email).collection("Devices").doc(plataforma);//uid o email
    if ((await deviceRef.get()).exists) {
      await deviceRef.update({
       "updated_at":nowMs,
       //"unistalled":false,
       });
    } else{
      await deviceRef.set({
        "modelo":modelo,
        "created_at": nowMs,
        "updated_at":nowMs,
        "id": deviceId,
    });
    }
  }
}