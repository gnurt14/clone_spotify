import '../../../domain/entities/song/song.dart';

abstract class FavoriteSongState{}

class FavoriteSongLoading extends FavoriteSongState{}

class FavoriteSongLoaded extends FavoriteSongState{
  final List<SongEntity> favoriteSong;

  FavoriteSongLoaded({
    required this.favoriteSong
  });
}

class FavoriteSongLoadFailure extends FavoriteSongState{}