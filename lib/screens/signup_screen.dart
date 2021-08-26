import 'package:firebase_auth/firebase_auth.dart';
import 'package:flu/provider/modelHud.dart';
import 'package:flu/screens/constants.dart';
import 'package:flu/screens/login_screen.dart';
import 'package:flu/services/auth.dart';
import 'package:flu/widget/custom_textfield.dart';
import 'package:flu/widget/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'SignUpScreen';
  late String _email, _password, _name;
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: KmainColor,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoading,
          child: Form(
            key: _globalKey,
            child: ListView(
              children: [
                Logo(),
                SizedBox(
                  height: height * .05,
                ),
                CustomTextField(
                  onClick: (value) {
                    _name = value;
                  },
                  hint: 'Enter Your Name',
                  icon: Icons.email,
                ),
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
                    builder: (context) => TextButton(
                        onPressed: () async {
                          final modelhub=Provider.of<ModelHud>(context,listen: false);
                          modelhub.changeisLoading(true);
                          if (_globalKey.currentState!.validate()) {
                            _globalKey.currentState!.save();

                            try {
                              await _auth.signUp(_email, _password);
                              modelhub.changeisLoading(false);
                            } on FirebaseAuthException catch (e) {
                              modelhub.changeisLoading(false);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(e.message ?? 'Something Error')));
                            };
                          }
                          modelhub.changeisLoading(false);
                        },
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            primary: Colors.white,
                            backgroundColor: Colors.black),
                        child: Text('SignUp')),
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
                        Navigator.pushNamed(context, Login.id);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}
