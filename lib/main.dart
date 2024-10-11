import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lingopandasameepjain/repositories/firebase_services.dart';
import 'package:provider/provider.dart';
import 'Provider/auth_provider.dart';
import 'Provider/news_provider.dart';
import 'UI/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase

  final remoteConfig = FirebaseRemoteConfig.instance;
  final remoteConfigService = RemoteConfigService(remoteConfig);

  // Fetch and activate remote config
  await remoteConfigService.fetchAndActivate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()), // Provide AuthProvider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),  // Start with LoginScreen or SignupScreen
      ),
    );
  }
}
