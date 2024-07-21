import 'package:clone_spotify/data/repository/auth/auth_repository_impl.dart';
import 'package:clone_spotify/data/repository/song/song_repository_impl.dart';
import 'package:clone_spotify/data/sources/song/song_firebase_sevice.dart';
import 'package:clone_spotify/domain/repository/auth/auth.dart';
import 'package:clone_spotify/domain/repository/song/song.dart';
import 'package:clone_spotify/domain/usecases/auth/get_user.dart';
import 'package:clone_spotify/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:clone_spotify/domain/usecases/song/get_news_songs.dart';
import 'package:clone_spotify/domain/usecases/song/get_play_list.dart';
import 'package:clone_spotify/domain/usecases/song/get_user_favorite_song.dart';
import 'package:clone_spotify/domain/usecases/song/is_favorite_song.dart';
import 'package:get_it/get_it.dart';
import 'package:clone_spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:clone_spotify/domain/usecases/auth/sign_in.dart';
import 'package:clone_spotify/domain/usecases/auth/sign_up.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongsRepository>(SongsRepositoryImpl());

  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());
  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(AddOrRemoveFavoriteSongUseCase());
  sl.registerSingleton<IsFavoriteSongUseCase>(IsFavoriteSongUseCase());
  sl.registerSingleton<GetUserFavoriteSongUseCase>(GetUserFavoriteSongUseCase());
}