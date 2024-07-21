import 'package:clone_spotify/presentation/auth/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../common/widgets/app_bar/app_bar.dart';
import '../../../../common/widgets/button/basic_app_button.dart';
import '../../../../core/assets/app_vectors.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../data/models/auth/sign_in_user_req.dart';
import '../../../../domain/usecases/auth/sign_in.dart';
import '../../../../service_locator.dart';
import '../../home/pages/home.dart';

class SignInPage extends StatelessWidget{
  SignInPage({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signUpText(context),
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
              _signInText(),
              const SizedBox(height: 50,),
              _emailField(context),
              const SizedBox(height: 30,),
              _passwordField(context),
              const SizedBox(height: 30,),
              BasicAppButton(
                title: 'Sign In',
                onPressed: () async{
                  var res = await sl<SignInUseCase>().call(
                      params: SignInUserReq(
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
  Widget _signInText(){
    return const Text(
      'Sign In',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
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
      controller: _password,
      obscureText: true,
      decoration: const InputDecoration(
          hintText: 'Enter Password'
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _signUpText(BuildContext context){
    return Padding(
      padding: const  EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Not A Member? ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: (){
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(
                  builder: (BuildContext context) =>  SignUpPage(),
                ),
              );
            },
            child: const Text(
              'Register Now',
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