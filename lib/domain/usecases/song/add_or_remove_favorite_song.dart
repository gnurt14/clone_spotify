import 'package:clone_spotify/core/usecase/usecase.dart';
import 'package:clone_spotify/domain/repository/song/song.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String ? params}) async{
    return await sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }
}