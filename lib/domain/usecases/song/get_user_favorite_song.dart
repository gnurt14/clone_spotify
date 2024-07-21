import 'package:clone_spotify/core/usecase/usecase.dart';
import 'package:clone_spotify/domain/repository/song/song.dart';
import 'package:clone_spotify/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetUserFavoriteSongUseCase implements UseCase<Either, dynamic>{
  @override
  Future<Either> call({params}) async{
    return await sl<SongsRepository>().getUserFavoriteSong();
  }

}