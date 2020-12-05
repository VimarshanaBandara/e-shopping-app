import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Counters/BookQuantity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'Counters/cartitemcounter.dart';
import 'Counters/changeAddresss.dart';
import 'Counters/totalMoney.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Store/storehome.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  EcommerceApp.firestore = Firestore.instance;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            title: 'e-Shop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.green,
            ),
            home: AuthenticScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
{

  @override
  void initState() {

    super.initState();
    displaySplash();

  }

    displaySplash(){

    Timer(Duration(seconds: 5), () async{
    if(EcommerceApp.auth.currentUser() != null) {
      Route route = MaterialPageRoute(builder: (_) => StoreHome());
      Navigator.pushReplacement(context, route);
    }
    else
      {
        Route route = MaterialPageRoute(builder: (_) => AuthenticScreen());
        Navigator.pushReplacement(context, route);
      }

    });

    }


  @override
  Widget build(BuildContext context) {
    return Material(
      child:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink , Colors.lightGreenAccent ],
            begin: const FractionalOffset(0.0,0.0),
            end: const FractionalOffset(1.0,0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/welcome.png"),
              SizedBox(height: 20.0,),
              Text("Worls Largest & Number Online Shop",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
            ],
          ),
        ),
      )
    );
  }
}
