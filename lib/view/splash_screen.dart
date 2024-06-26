import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakysoft_test/controller/user_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UserController>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: controller.splashScreenLoader(context),
        builder: (context, snapshot) {
          return Center(
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText('ZakySoft',
                    speed: const Duration(milliseconds: 80),
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
