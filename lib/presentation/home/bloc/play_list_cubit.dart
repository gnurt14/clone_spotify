import 'package:clone_spotify/domain/usecases/song/get_play_list.dart';
import 'package:clone_spotify/presentation/home/bloc/play_list_state.dart';
import 'package:clone_spotify/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/song/song.dart';

class PlayListCubit extends Cubit<PlayListState>{

  PlayListCubit() : super(PlayListLoading());

  List<SongEntity> songs = [];

  Future<void> getPlayList() async{
    var returnedSongs = await sl<GetPlayListUseCase>().call();
    if(!isClosed){
      returnedSongs.fold(
        (l){
          emit(PlayListLoadFailure());
        },
      (data){
        songs = data;
        emit(
            PlayListLoaded(songs: songs)
        );
      }
      );
    }
  }
}