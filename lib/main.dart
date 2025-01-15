import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:swaply/core/confg_provider.dart';
import 'package:swaply/services/auth-service.dart';
import 'package:swaply/ui/pages/home_pege.dart';
import 'package:swaply/ui/widgets/item_form_card.dart';
import 'package:swaply/ui/widgets/login_or_register_page.dart';
import 'firebase_options.dart'; 

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final data = await ConfigureProviders.createDependencyTree();
  runApp(MyApp(data: data));
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key, required this.data});
  final ConfigureProviders data;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: data.providers,
      child: MaterialApp(
        title: 'Swaply',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 81, 196, 106)),
          useMaterial3: true,
        ),
        home:  const HomePage(),
      ),
    );
  }
}