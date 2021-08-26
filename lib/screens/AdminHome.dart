import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flu/screens/constants.dart';
import 'package:flu/screens/addProduct.dart';
import 'package:flu/screens/editProduct.dart';


class AdminHome extends StatelessWidget{
  static String id = 'AdminHome';
    @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return Scaffold(
       backgroundColor: KmainColor,
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           SizedBox(
             width: double.infinity,
           ),
           ElevatedButton(onPressed: (){

             Navigator.pushNamed(context,AddProduct.id);

           } , child: Text('Add Product')),
           SizedBox(
             width: double.infinity,
           ),
           ElevatedButton(onPressed:(){
                Navigator.pushNamed(context, EditProduct.id);
           } , child: Text('Edit Product')),
           SizedBox(
             width: double.infinity,
           ),
           ElevatedButton(onPressed:(){

           } , child: Text('view Product')),
           SizedBox(
             width: double.infinity,
           ),
         ],
       ),
     );
  }

}