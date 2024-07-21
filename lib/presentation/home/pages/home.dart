import 'package:clone_spotify/common/helpers/is_dark_mode.dart';
import 'package:clone_spotify/common/widgets/app_bar/app_bar.dart';
import 'package:clone_spotify/core/assets/app_images.dart';
import 'package:clone_spotify/core/assets/app_vectors.dart';
import 'package:clone_spotify/core/configs/theme/app_colors.dart';
import 'package:clone_spotify/presentation/profile/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/news_songs.dart';
import '../widgets/play_list.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 50,
          width: 50,
        ),
        action: IconButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => const ProfilePage()));
          },
          icon: const Icon(Icons.person),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _tabs(),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                children: [
                  const NewsSongs(),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                ]
              ),
            ),
            const PlayList(),
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard(){
    return Center(
      child:  SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppVectors.homeTopCard,
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Image.asset(
                  AppImages.homeArtist
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs(){
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      indicatorColor: AppColors.primary,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      padding: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      dividerColor: Colors.transparent,
      tabs:const [
        Text(
          'News',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18
          ),
        ),
        Text(
          'Videos',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18
          ),
        ),
        Text(
          'Artists',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18
          ),
        ),
        Text(
          'Podcasts',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18
          ),
        ),
        Text(
          'Trending',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18
          ),
        ),
      ],
    );
  }
}