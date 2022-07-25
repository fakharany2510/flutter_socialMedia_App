import 'package:firebase_auth/firebase_auth.dart';

abstract class BrowiseRegisterStates{}
class BrowiseRegisterInitialState extends BrowiseRegisterStates{}
class BrowiseRegisterLoadingState extends BrowiseRegisterStates{}
class BrowiseRegisterSucessState extends BrowiseRegisterStates{

}
class BrowiseRegisterErrorState extends BrowiseRegisterStates{
}
//--------------
class BrowiseCreateUserSucessState extends BrowiseRegisterStates{
  String userName;
  BrowiseCreateUserSucessState(this.userName);
}
class BrowiseCreateUserErrorState extends BrowiseRegisterStates{
  FirebaseAuthException error;
  BrowiseCreateUserErrorState(this.error);

}