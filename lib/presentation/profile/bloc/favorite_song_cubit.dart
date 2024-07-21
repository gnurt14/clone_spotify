import 'package:clone_spotify/domain/usecases/song/get_user_favorite_song.dart';
import 'package:clone_spotify/presentation/profile/bloc/favorite_song_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/song/song.dart';
import '../../../service_locator.dart';


class FavoriteSongCubit extends Cubit<FavoriteSongState>{
  FavoriteSongCubit() : super(FavoriteSongLoading());

  List<SongEntity> favoriteSong = [];

  Future<void> getFavoriteSongs() async{
    var res = await sl<GetUserFavoriteSongUseCase>().call();

    res.fold(
      (l){
        emit(
          FavoriteSongLoadFailure()
        );
      },
      (r){
        favoriteSong = r;
        emit(
          FavoriteSongLoaded(favoriteSong: favoriteSong)
        );
      }
    );
  }

  void removeSong(int index){
    if (favoriteSong.isNotEmpty) {
      favoriteSong.removeAt(index);
      emit(FavoriteSongLoaded(favoriteSong: favoriteSong));
    }
  }
}