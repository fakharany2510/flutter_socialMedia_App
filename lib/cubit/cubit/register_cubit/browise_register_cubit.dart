import 'package:browis_it/cubit/states/browise_login_states/browise_it_login_states.dart';
import 'package:browis_it/cubit/states/browise_register_states/browise_register_states.dart';
import 'package:browis_it/models/new_user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class BrowiseRegisterCubit extends Cubit<BrowiseRegisterStates>{
  BrowiseRegisterCubit() : super(BrowiseRegisterInitialState());
  static BrowiseRegisterCubit get(context)=>BlocProvider.of(context);
  
//-------------------------------------
  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }){
    emit(BrowiseRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value){
          //--------Register And Create New User
      createNewUsre(
          userId: value.user!.uid,
          phone: phone,
          name: name,
          email: email
      );
          print(value.user!.email);
          emit(BrowiseRegisterSucessState());
    }).catchError((error){
      print(error.toString());
      emit(BrowiseRegisterErrorState());
    });
  }
  //-------------Create New User and add it to firestore--------------------------------------

   void createNewUsre({
     required String userId,
     required String email,
     required String name,
     required String phone,
   }){
     BrowiseUserModel model=BrowiseUserModel(
       userId: userId,
       email: email,
       name: name,
       phone: phone,
       bio:'write your bio....',
       image: 'https://img.freepik.com/free-photo/pretty-young-afro-american-girl-looks-aside-with-toothy-smile-notices-pleasant-thing-has-carefree-expression-dressed-casual-jumper-poses-indoor-against-vivid-orange-wall_273609-47744.jpg?w=740',
       cover: 'https://img.freepik.com/free-photo/pretty-young-afro-american-girl-looks-aside-with-toothy-smile-notices-pleasant-thing-has-carefree-expression-dressed-casual-jumper-poses-indoor-against-vivid-orange-wall_273609-47744.jpg?w=740&t=st=1650054974~exp=1650055574~hmac=97b4f483e006daa44cea76c8fd340e3ae3e453bc96d5bc52aedfa6339825044c',
       isEmailVrefied: false,
     );
     FirebaseFirestore
         .instance
         .collection('users')
         .doc(userId)
         .set(
         model.toMap()).then((value){
       emit(BrowiseCreateUserSucessState(name));
     }).catchError((error){
       emit(BrowiseCreateUserErrorState(error));
     });
   }
  IconData suffix= Icons.visibility;
  bool isPasswordShown=false;
  void changePasswordState(){
    isPasswordShown= !isPasswordShown;
    suffix= isPasswordShown ?  Icons.visibility : Icons.visibility_off;
  }
}