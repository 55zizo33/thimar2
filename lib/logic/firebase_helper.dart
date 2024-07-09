import 'package:app/logic/helper_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../firebase_options.dart';

class FirebaseHelper
{
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await  getFVMToken();
  }

  Future<String?> getFVMToken()async{
    var permission = await Permission.notification.request();
    print(permission);
    if(!permission.isGranted) {
      showModalBottomSheet(
        context: navigatorKey.currentContext!
        , builder: (context) => Container(
        width: double.infinity,
          child: Column(
          children: [
            Text("Please give me access"),
            ElevatedButton(onPressed: ()async {
              await openAppSettings();
            },
              child: Text("Allow"),)
          ],
                ),
        ),);
    }
    String? token=await FirebaseMessaging.instance.getToken();
    print("FCM----> $token");
    if(token==null){
      showMessage("Something wrong While getting FCM Token");
      return null;
    }
   return token ;

  }





}