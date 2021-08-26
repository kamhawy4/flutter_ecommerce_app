import 'package:firebase_auth/firebase_auth.dart';
import 'package:flu/provider/adminMode.dart';
import 'package:flu/provider/modelHud.dart';
import 'package:flu/screens/constants.dart';
import 'package:flu/widget/custom_textfield.dart';
import 'package:flu/widget/logo.dart';
import 'package:flu/services/auth.dart';
import 'package:flu/screens/signup_screen.dart';
import 'package:flu/screens/AdminHome.dart';
import 'package:flu/screens/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static String id = 'LoginScreen';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  //final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
  //static String id = 'LoginScreen';
  late String _email, _password;
  final _auth = Auth();
  final adminPassword = 'Admin1234';

  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: KmainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider
            .of<ModelHud>(context)
            .isLoading,
        child: Form(
          key: widget.globalKey,
          child: ListView(
            children: [
              Logo(),
              SizedBox(
                height: height * .05,
              ),
              CustomTextField(
                onClick: (value) {
                  _email = value;
                },
                hint: 'Enter Your Email',
                icon: Icons.email,
              ),
              SizedBox(
                height: height * .05,
              ),
              CustomTextField(
                onClick: (value) {
                  _password = value;
                },
                hint: 'Enter Your Password',
                icon: Icons.lock,
              ),
              SizedBox(
                height: height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) =>
                      TextButton(
                          onPressed: () async {
                            _validate(context);
                          },
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              primary: Colors.white,
                              backgroundColor: Colors.black),
                          child: Text('Login')),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'dont have anu account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Text(
                      'SignUp',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeIsAdmin(true);
                        },
                        child: Text('i\'m an admin',
                          style: TextStyle(
                            color: Provider
                                .of<AdminMode>(context)
                                .isAdmin ? KmainColor : Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeIsAdmin(false);
                        },
                        child: Text('i\'m a user',
                          style: TextStyle(
                            color: Provider
                                .of<AdminMode>(context)
                                .isAdmin ? Colors.white : KmainColor,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeisLoading(true);
    if (widget.globalKey.currentState!.validate()) {
      widget.globalKey.currentState!.save();
      if (Provider
          .of<AdminMode>(context, listen: false)
          .isAdmin) {
        if (_password == adminPassword) {
          try {
            await _auth.signIn(_email.trim(), _password.trim());
            Navigator.pushNamed(context, AdminHome.id);
          } on FirebaseAuthException catch (e) {
            modelhud.changeisLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(e.message ?? 'Something Error')));
          }
        } else {
          modelhud.changeisLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong !'),
          ));
        }
      } else {
        try {
          await _auth.signIn(_email.trim(), _password.trim());
          Navigator.pushNamed(context, HomePage.id);
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.message ?? 'Something Error')));
        }
      }
    }
    modelhud.changeisLoading(false);
  }
}
