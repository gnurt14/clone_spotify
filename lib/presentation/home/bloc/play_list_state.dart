import 'package:clone_spotify/domain/entities/song/song.dart';

sealed class PlayListState{}

class PlayListLoading extends PlayListState{}

class PlayListLoaded extends PlayListState{
  final List<SongEntity> songs;
  PlayListLoaded({required this.songs});
}

class PlayListLoadFailure extends PlayListState{}