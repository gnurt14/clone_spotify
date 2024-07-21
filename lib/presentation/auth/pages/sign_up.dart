import 'package:clone_spotify/presentation/auth/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/widgets/app_bar/app_bar.dart';
import '../../../../common/widgets/button/basic_app_button.dart';
import '../../../../core/assets/app_vectors.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../data/models/auth/create_user_req.dart';
import '../../../../domain/usecases/auth/sign_up.dart';
import '../../../../service_locator.dart';
import '../../home/pages/home.dart';


class SignUpPage extends StatelessWidget{
  SignUpPage({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signInText(context),
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          width: 50,
          height: 50,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              const SizedBox(height: 50,),
              _fullNameField(context),
              const SizedBox(height: 30,),
              _emailField(context),
              const SizedBox(height: 30,),
              _passwordField(context),
              const SizedBox(height: 30,),
              BasicAppButton(
                title: 'Create Account',
                onPressed: () async {
                 var res = await sl<SignUpUseCase>().call(
                   params: CreateUserReq(
                     fullName: _fullName.text,
                     email: _email.text,
                     password: _password.text)
                 );
                 res.fold(
                   (l){
                     var snackBar = SnackBar(content: Text(l));
                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                   },
                   (r) {
                     Navigator.pushAndRemoveUntil(
                       context,
                       MaterialPageRoute(
                         builder: (BuildContext context) =>  HomePage(),
                       ),
                       (route) => false
                     );
                   },
                 );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _registerText(){
    return const Text(
      'Register',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }
  Widget _fullNameField(BuildContext context){
    return TextField(
      controller: _fullName,
      decoration: const InputDecoration(
        hintText: 'Full name'
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme
      ),
    );
  }
  Widget _emailField(BuildContext context){
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
          hintText: 'Enter Email'
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }
  Widget _passwordField(BuildContext context){
    return TextField(
      obscureText: true,
      controller: _password,
      decoration: const InputDecoration(
          hintText: 'Enter Password'
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _signInText(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Do you have an account? ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context)
                =>  SignInPage()
                ),
              );
            },
            child:const Text(
              'Sign In',
                style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}