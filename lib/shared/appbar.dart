import 'package:flutter/material.dart';

AppBar buildAppBar({required String title}) {
  return AppBar(
    backgroundColor: Colors.deepPurple,
    title: Text(title),
    centerTitle: true,
  );
}
