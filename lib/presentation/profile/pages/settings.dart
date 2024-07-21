import 'package:clone_spotify/common/helpers/is_dark_mode.dart';
import 'package:clone_spotify/common/widgets/app_bar/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../choose_mode/bloc/theme_cubit.dart';

class SettingsPage extends StatefulWidget{
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool  _enable = context.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Dark mode',
                      style: TextStyle(
                        fontSize: 18,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(width: 30,),
                    CupertinoSwitch(
                      value: _enable,
                      onChanged: (value) {
                        _enable = value;
                        if(context.isDarkMode){
                          context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                        }else{
                          context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              child: TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 30,
                      color: context.isDarkMode ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 30,),
                    Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 18,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}