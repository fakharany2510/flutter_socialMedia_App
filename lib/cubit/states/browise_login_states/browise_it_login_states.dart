import 'package:firebase_auth/firebase_auth.dart';
abstract class BrowiseLoginStates{}
class BrowiseLoginInitialState extends BrowiseLoginStates{}
class BrowiseLoginLoadingState extends BrowiseLoginStates{}
class BrowiseLoginSucessState extends BrowiseLoginStates{
  String userName;
  BrowiseLoginSucessState(this.userName);
}
class BrowiseLoginErrorState extends BrowiseLoginStates{
  FirebaseAuthException error;
  BrowiseLoginErrorState(this.error);

}
//--------------------------
