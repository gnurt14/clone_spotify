import 'package:clone_spotify/common/helpers/is_dark_mode.dart';
import 'package:clone_spotify/common/widgets/app_bar/app_bar.dart';
import 'package:clone_spotify/presentation/profile/bloc/favorite_song_cubit.dart';
import 'package:clone_spotify/presentation/profile/bloc/favorite_song_state.dart';
import 'package:clone_spotify/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:clone_spotify/presentation/profile/pages/settings.dart';
import 'package:clone_spotify/presentation/song_player/pages/song_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../core/configs/constants/app_urls.dart';
import '../bloc/profile_info_state.dart';


class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
          'Profile',
        ),
        action: IconButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const SettingsPage()
              )
            );
          },
          icon: Icon(
            Icons.settings,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,

      ),
      body: Column(
        children: [
          _profileInfo(context),
          const SizedBox(height: 15,),
          _favoriteSong(context),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context){
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height/ 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
            color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            )
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state){
            if(state is ProfileInfoLoading){
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator()
              );
            }
            if(state is ProfileInfoLoaded){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            state.userEntity.imageUrl!,
                        )
                      )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    state.userEntity.email!,
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    state.userEntity.fullName!,
                    style:const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              );
            }
            if(state is ProfileInfoLoadFailure){
              return const Text('Please try again');
            }
            return Container();
          },
        ),
      ),
    );
  }
  Widget _favoriteSong(BuildContext context){
    return BlocProvider(
      create: (context) => FavoriteSongCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FAVORITE SONG',
            ),
            const SizedBox(height: 20,),
            BlocBuilder<FavoriteSongCubit, FavoriteSongState>(
              builder: (context, state){
                if(state is FavoriteSongLoading){
                  return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                }
                if(state is FavoriteSongLoaded){
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => SongPlayerPage(songEntity: state.favoriteSong[index])
                            )
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            '${AppUrls.coverFirestorage}${Uri.encodeComponent(state.favoriteSong[index].title)} - ${Uri.encodeComponent(state.favoriteSong[index].artist)}.jpg?${AppUrls.mediaAlt}',
                                          )
                                      )
                                  ),
                                ),
                                const SizedBox(width: 15,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * 0.5,
                                      ),
                                      child: Text(
                                        state.favoriteSong[index].title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * 0.5,
                                      ),
                                      child: Text(
                                        state.favoriteSong[index].artist,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.2,
                                  ),
                                  child: Text(
                                    state.favoriteSong[index].duration.toString().replaceAll('.', ':'),
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                FavoriteButton(
                                  songEntity: state.favoriteSong[index],
                                  key: UniqueKey(),
                                  function: (){
                                    context.read<FavoriteSongCubit>().removeSong(index);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 20,),
                    itemCount: state.favoriteSong.length,
                  );
                }
                if(state is FavoriteSongLoadFailure){
                  return const Text('An error occurred, please try again');
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}