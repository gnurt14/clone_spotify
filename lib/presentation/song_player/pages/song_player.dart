import 'package:clone_spotify/common/widgets/app_bar/app_bar.dart';
import 'package:clone_spotify/common/widgets/favorite_button/favorite_button.dart';
import 'package:clone_spotify/domain/entities/song/song.dart';
import 'package:clone_spotify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:clone_spotify/presentation/song_player/bloc/song_player_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/configs/constants/app_urls.dart';
import '../../../core/configs/theme/app_colors.dart';

class SongPlayerPage extends StatelessWidget{
  final SongEntity songEntity;
  const SongPlayerPage({
    super.key,
    required this.songEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
          'Now Playing',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_sharp),
        ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadSong(
          '${AppUrls.songFirestorage}${Uri.encodeComponent(songEntity.title)} - ${Uri.encodeComponent(songEntity.artist)}.mp3?${AppUrls.mediaAlt}',
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(height: 20,),
              _songDetail(context),
              const SizedBox(height: 20,),
              _songPlayer(context),
            ],
          ),
        ),
      ),
    );
  }
  Widget _songCover(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height/2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            '${AppUrls.coverFirestorage}${Uri.encodeComponent(songEntity.title)} - ${Uri.encodeComponent(songEntity.artist)}.jpg?${AppUrls.mediaAlt}',
          )
        )
      ),
    );
  }
  Widget _songDetail(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Text(
                songEntity.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              songEntity.artist,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            )
          ],
        ),
        FavoriteButton(songEntity: songEntity),
      ],
    );
  }
  Widget _songPlayer(BuildContext context){
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state){
        if(state is SongPlayerLoading){
          return const CircularProgressIndicator();
        }
        if(state is SongPlayerLoaded){
          return Column(
            children: [
              Slider(
                value: state.position.inSeconds.toDouble(),
                min: 0.0,
                max: state.duration.inSeconds.toDouble(),
                onChanged: (value){
                  context.read<SongPlayerCubit>().seekTo(Duration(seconds: value.toInt()));
                }
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(
                      state.position
                    ),
                  ),
                  Text(
                    formatDuration(
                        state.duration
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  context.read<SongPlayerCubit>().playOrPauseSong();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Icon(
                    context.read<SongPlayerCubit>().audioPlayer.playing ? Icons.pause : Icons.play_arrow_rounded
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
  String formatDuration(Duration duration){
    final seconds = duration.inSeconds.remainder(60);
    final minutes = duration.inMinutes.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}