import 'dart:async';

import 'package:clone_spotify/presentation/song_player/bloc/song_player_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  // Use StreamSubscriptions to manage the listeners
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration?>? _durationSubscription;

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    _positionSubscription = audioPlayer.positionStream.listen((position) {
      songPosition = position;
      emit(SongPlayerLoaded(
        duration: songDuration,
        position: songPosition,
      ));
    });

    _durationSubscription = audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
        emit(SongPlayerLoaded(
          duration: songDuration,
          position: songPosition,
        ));
      }
    });
  }


  void updateSongPlayer(){
    emit(
        SongPlayerLoaded(
          duration: songDuration,
          position: songPosition,
        )
    );
  }

  Future<void> loadSong(String url) async{
    try{
      await audioPlayer.setUrl(url);
      emit(
          SongPlayerLoaded(
            duration: songDuration,
            position: songPosition,
          )
      );

      playOrPauseSong();
    } catch (e){
      emit(
        SongPlayerLoadFailure()
      );
    }
  }

  void playOrPauseSong(){
    if(audioPlayer.playing){
      audioPlayer.stop();
    } else {
      audioPlayer.play();
    }
    emit(
        SongPlayerLoaded(
          duration: songDuration,
          position: songPosition,
        )
    );
  }

  void seekTo(Duration position){
    audioPlayer.seek(position);
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    audioPlayer.dispose();
    return super.close();
  }
}