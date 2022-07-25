import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:browis_it/cubit/states/browise_login_states/browise_it_login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
class BrowiseLoginCubit extends Cubit<BrowiseLoginStates>{
  BrowiseLoginCubit() : super(BrowiseLoginInitialState());
  static BrowiseLoginCubit get(context)=>BlocProvider.of(context);

   void userLogin({
  required String email,
    required String password,
}){
    emit(BrowiseLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
    .then((value){
      emit(BrowiseLoginSucessState(email));
      print(value.user!.email);
    }).catchError((error){
      print(error.toString());
      emit(BrowiseLoginErrorState(error));
    });

  }

  IconData suffix= Icons.visibility;
  bool isPasswordShown=false;
  void changePasswordState(){
    isPasswordShown= !isPasswordShown;
    suffix= isPasswordShown ?  Icons.visibility : Icons.visibility_off;
  }
}