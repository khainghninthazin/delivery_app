import 'package:delivery_app/auth/login&register.dart';
import 'package:delivery_app/pages/restaurants.dart';
import 'package:delivery_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  
  //   WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  Supabase.initialize(
    url:'https://poaaetkuaibcogxnqttp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBvYWFldGt1YWliY29neG5xdHRwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIwNzgzMjAsImV4cCI6MjA0NzY1NDMyMH0.EEKPbU-ffS31x7alqAv03oIbjErNt7gdsoGnsYw9RGs'
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> ThemeProvider()),

      ChangeNotifierProvider(create: (context)=> Restaurant()),
    ],
    child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const  LoginOrRegister(
        
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}