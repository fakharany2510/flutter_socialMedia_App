import 'package:browis_it/bloc/bloc_observer.dart';
import 'package:browis_it/cubit/cubit/app_cubit.dart';
import 'package:browis_it/excel.dart';
import 'package:browis_it/modules/login/login_screen.dart';
import 'package:browis_it/provider_concepts/modules/ui_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> _firebaseMessagingBackgroundHandler( RemoteMessage message, ) async {
  print('this is the message');
  print(message.data.toString());
  Fluttertoast.showToast(
    msg: 'hellow from out app',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );

}
void main()async {
  runApp( MyApp());
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();
  print("tken ------------> ${token}");
  FirebaseMessaging.onMessage.listen((event) {
    Fluttertoast.showToast(
      msg: 'on Message',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    Fluttertoast.showToast(
      msg: 'on Message open App',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context)=>BrowiseCubit()..getUserData()..getPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Splash screen Demo',
        home: example1,
      ),
    );





     /* MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context)=>BrowiseCubit()..getUserData(),
        ),
      ],
      child: BlocConsumer<BrowiseCubit,BrowiseStates>(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoginScreen(),
          );
        },
      ),
    );*/
  }
  Widget example1 = SplashScreenView(
    navigateRoute:LoginScreen(),
    duration: 5000,
    imageSize: 130,
    imageSrc: "assets/images/blogin3.png",
    text: "Browise_it",
    textType: TextType.ColorizeAnimationText,
    textStyle: TextStyle(
      fontSize: 40.0,
    ),
    colors: [
      HexColor('#ff8800'),
      Colors.black,
      Colors.grey.shade600
    ],
    backgroundColor: Colors.white,
  );
}