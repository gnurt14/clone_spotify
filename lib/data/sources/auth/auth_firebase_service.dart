import 'package:clone_spotify/core/configs/constants/app_urls.dart';
import 'package:clone_spotify/data/models/auth/user.dart';
import 'package:clone_spotify/domain/entities/auth/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/auth/create_user_req.dart';
import '../../models/auth/sign_in_user_req.dart';


abstract class AuthFirebaseService{

  Future<Either> signUp(CreateUserReq createUserReq);

  Future<Either> signIn(SignInUserReq signInUserReq);

  Future<Either> getUser();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService{
  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInUserReq.email,
        password: signInUserReq.password,
      );

      return const Right('SignIn was successfully');

    } on FirebaseException catch (e){
      String message = '';
      if(e.code == 'invalid-email'){
        message = 'Not user found for this email.';
      }else if(e.code == 'invalid-credential'){
        message = 'Wrong password.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    try{
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email,
          password: createUserReq.password,
      );
      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid)
          .set(
        {
          'name': createUserReq.fullName,
          'email': data.user?.email,
        }
      );
      return const Right('SignUp was successfully');

    } on FirebaseException catch (e){
      String message = '';
      if(e.code == 'weak-password'){
        message = 'The password provided is too weak';
      }else if(e.code == 'email-already-in-use'){
        message = 'An account already exist with that email.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user =  await firebaseFirestore.collection('Users').doc(
          firebaseAuth.currentUser?.uid
      ).get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageUrl = firebaseAuth.currentUser?.photoURL ?? AppUrls.defaultImage;
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    }
    catch (e){
      return const Left('An error occurred');
    }
  }
}