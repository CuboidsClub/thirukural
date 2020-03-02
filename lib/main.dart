import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(BiherEg());
}

class BiherEg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Comfortaa'),
        debugShowCheckedModeBanner: false, title: "Thirukural", home: Home());
  }
}
