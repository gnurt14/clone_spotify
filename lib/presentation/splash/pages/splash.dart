import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets/app_vectors.dart';
import '../../intro/pages/get_started.dart';

class SplashPage extends StatefulWidget{
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState(){
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              AppVectors.logo,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> redirect() async{
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const GetStartedPage()
      ),
    );
  }
}