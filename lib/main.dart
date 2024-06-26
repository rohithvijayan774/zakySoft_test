import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakysoft_test/controller/user_controller.dart';
import 'package:zakysoft_test/services/database_helper.dart';
import 'package:zakysoft_test/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  await dataBaseHelper.getDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserController>(
          create: (context) => UserController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zakysoft Test',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
