import 'package:flutter/material.dart';
import 'package:movie_flutter/views/register_user_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => RegisterUserView(),
    },
  ));
}
