import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../../common/widgets/button/basic_app_button.dart';
import '../../../../core/assets/app_images.dart';
import '../../../../core/assets/app_vectors.dart';
import '../../choose_mode/pages/choose_mode.dart';

class GetStartedPage extends StatelessWidget{
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding:const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40,
            ),
            decoration:const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppImages.introBG,
                )
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.25),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 80,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    AppVectors.logo,
                    width: 200,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Enjoy Listening to Music',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 21,
                  ),
                ),
                const SizedBox(height: 20,),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. sed do eiusmod incididunt ut labore et dolore magna aliqua',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20,),
                BasicAppButton(
                  title: 'Get Started',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                            const ChooseModePage(),
                        ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}