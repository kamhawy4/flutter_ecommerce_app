import 'package:firebase_core/firebase_core.dart';
import 'package:flu/provider/modelHud.dart';
import 'package:flu/provider/adminMode.dart';
import 'package:flu/screens/login_screen.dart';
import 'package:flu/screens/AdminHome.dart';
import 'package:flu/screens/addProduct.dart';
import 'package:flu/screens/HomePage.dart';
import 'package:flu/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flu/screens/editProduct.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
    ChangeNotifierProvider<ModelHud>(
    create: (context)=>ModelHud(),
    ),
    ChangeNotifierProvider<AdminMode>(
    create: (context)=>AdminMode(),
    ),
    ],
      child:  MaterialApp(
        initialRoute: Login.id,
        routes: {
          Login.id: (context) => Login(),
          SignUpScreen.id: (context) => SignUpScreen(),
          HomePage.id: (context) => HomePage(),
          AdminHome.id: (context) => AdminHome(),
          AddProduct.id: (context) => AddProduct(),
          EditProduct.id: (context) => EditProduct()
        },
      ),
    );
  }
}
