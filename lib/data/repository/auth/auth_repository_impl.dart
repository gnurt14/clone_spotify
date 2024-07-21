import 'package:dartz/dartz.dart';

import '../../../domain/repository/auth/auth.dart';
import '../../../service_locator.dart';
import '../../models/auth/create_user_req.dart';
import '../../models/auth/sign_in_user_req.dart';
import '../../sources/auth/auth_firebase_service.dart';

class AuthRepositoryImpl extends AuthRepository{

  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async{
    return await sl<AuthFirebaseService>().signIn(signInUserReq);
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async{
    return await sl<AuthFirebaseService>().signUp(createUserReq);
  }

  @override
  Future<Either> getUser() async{
    return await sl<AuthFirebaseService>().getUser();
  }
}