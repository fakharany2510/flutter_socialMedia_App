import 'package:flutter/src/foundation/change_notifier.dart';
class Model extends ChangeNotifier{
  String  name='ahmed';
  void changUserName(){
   name='ali';
   notifyListeners();
 }
}