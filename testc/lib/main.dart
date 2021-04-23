import 'package:flutter/material.dart';
import 'src/main_screen.dart';
import 'src/auth/android_auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthProvider().initialize();
  //await Firebase.initializeApp();
  runApp(MyApp());
}
