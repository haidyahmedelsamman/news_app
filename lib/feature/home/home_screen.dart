import 'package:flutter/material.dart';
import 'package:news_app/feature/home/ui/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white,
        child: Image.asset(

          "assets/images/pattern.png",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
      const Scaffold(
        backgroundColor: Colors.transparent,
        body: HomeBody(),
      ),
    ]);
  }
}
