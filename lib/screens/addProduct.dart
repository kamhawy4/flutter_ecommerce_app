import 'package:flutter/cupertino.dart';
import 'package:flu/models/product.dart';
import 'package:flu/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flu/screens/constants.dart';
import 'package:flu/services/store.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';

  late String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: KmainColor,
      body: Form(
        key: _globalKey,
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          CustomTextField(
              hint: 'Product Name',
              onClick: (value) {
                _name = value;
              },
              icon: Icons.drive_file_rename_outline),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
              onClick: (value) {
                _price = value;
              },
              hint: 'Product Price',
              icon: Icons.price_change),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
              onClick: (value) {
                _description = value;
              },
              hint: 'Product Description',
              icon: Icons.description),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
              onClick: (value) {
                _category = value;
              },
              hint: 'Product Category',
              icon: Icons.category),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
              onClick: (value) {
                _imageLocation = value;
              },
              hint: 'Product Image',
              icon: Icons.image
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: (){

            if (_globalKey.currentState!.validate()) {
              _globalKey.currentState!.save();

              _store.addProduct(Product(
                  pName: _name,
                  pPrice: _price,
                  pDescription: _description,
                  pLocation: _imageLocation,
                  pCategory: _category));
            }


          }, child: Text('Add Product'))

        ],
      )),
    );
  }
}
