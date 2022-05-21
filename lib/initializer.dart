import 'package:ams_lab7/app/view/app.dart';
import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

Future<Widget> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  RepositoryCollection().init(); //init repository collection
  return const App();
}
