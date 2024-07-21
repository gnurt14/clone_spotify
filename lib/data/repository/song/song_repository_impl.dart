import 'package:clone_spotify/data/sources/song/song_firebase_sevice.dart';
import 'package:clone_spotify/domain/repository/song/song.dart';
import 'package:clone_spotify/service_locator.dart';
import 'package:dartz/dartz.dart';



class SongsRepositoryImpl extends SongsRepository {

  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlaylist() async{
    return await sl<SongFirebaseService>().getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async{
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSongs(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) async{
    return await sl<SongFirebaseService>().isFavoriteSong(songId);
  }

  @override
  Future<Either> getUserFavoriteSong() async{
    return await sl<SongFirebaseService>().getUserFavoriteSong();
  }

}