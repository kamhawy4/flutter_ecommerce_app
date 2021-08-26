import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
          height: MediaQuery.of(context).size.height * .2,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image(
                image: AssetImage('images/icons/iconbuy.png'),
              ),
              Positioned(
                  bottom: 0,
                  child: Text(
                    'Buy it',
                    style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                  ))
            ],
          )),
    );
  }
}
