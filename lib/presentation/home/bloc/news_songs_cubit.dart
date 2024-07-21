import 'package:clone_spotify/domain/usecases/song/get_news_songs.dart';
import 'package:clone_spotify/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_songs_state.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {

  NewsSongsCubit() : super(NewsSongsLoading());

  Future < void > getNewsSongs() async {
    var returnedSongs = await sl < GetNewsSongsUseCase > ().call();
    if(!isClosed){
      returnedSongs.fold(
              (l) {
            emit(NewsSongsLoadFailure());
          },
              (data) {
            emit(
                NewsSongsLoaded(songs: data)
            );
          }
      );
    }
  }
}