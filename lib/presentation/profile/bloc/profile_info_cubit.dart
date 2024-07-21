import 'package:clone_spotify/domain/usecases/auth/get_user.dart';
import 'package:clone_spotify/presentation/profile/bloc/profile_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState>{
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async{
    var user = await sl<GetUserUseCase>().call();

    user.fold(
        (l){
          emit(ProfileInfoLoadFailure());
        },
        (userEntity){
          emit(ProfileInfoLoaded(userEntity: userEntity));
        }
    );
  }
}