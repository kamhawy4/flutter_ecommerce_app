import 'package:flu/screens/constants.dart';
import 'package:flu/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final _firestore = FirebaseFirestore.instance;

  addProduct(Product product) {
    _firestore.collection(kProductsCollection).add({
      kProductName: product.pName,
      kProductDescription: product.pDescription,
      kProductLocation: product.pLocation,
      kProductCategory: product.pCategory,
      kProductPrice: product.pPrice
    });
  }

   Stream<QuerySnapshot> loadProduct()  {
    return  _firestore.collection(kProductsCollection).snapshots();
  }
}
