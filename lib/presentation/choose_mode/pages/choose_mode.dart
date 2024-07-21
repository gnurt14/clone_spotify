import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/widgets/button/basic_app_button.dart';
import '../../../../core/assets/app_images.dart';
import '../../../../core/assets/app_vectors.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../auth/pages/signup_or_signin.dart';
import '../bloc/theme_cubit.dart';


class ChooseModePage extends StatelessWidget{
  const ChooseModePage({super.key});

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
                    AppImages.chooseModeBG,
                  )
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 100,
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
                  'Choose Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xff30393C).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  AppVectors.moon,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 60,),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xff30393C).withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  AppVectors.sun,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Text(
                          'Light Mode',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50,),
                BasicAppButton(
                  title: 'Continue',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) =>
                      const SignupOrSignInPage(),
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