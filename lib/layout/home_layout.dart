import 'package:browis_it/cubit/cubit/app_cubit.dart';
import 'package:browis_it/cubit/states/app_states.dart';
import 'package:browis_it/modules/new_posts/new_posts.dart';
import 'package:browis_it/shared/components.dart';
import 'package:browis_it/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrowiseCubit,BrowiseStates>(
      listener: (context,state){
        if(state is BrowiseNewPostState){
          pageRouter(context,NewPosts());
        }
      },
      builder: (context , state){
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: AppBar(
            iconTheme: IconThemeData(
                color: Colors.black
            ),
            actions: [
              IconButton(
                icon:Icon(Icons.notification_important_outlined,color: Colors.black,), onPressed: () {},
              ),
              IconButton(
                icon:Icon(Icons.search,color: Colors.black,), onPressed: () {},
              )
            ],
            centerTitle: false,
            titleSpacing: 0,
            title: Text(
              BrowiseCubit.get(context).titles[BrowiseCubit.get(context).currentIndex],
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),),
            elevation: 0.0,
            backgroundColor: Colors.white,
          ),
          body: BrowiseCubit.get(context).screens[BrowiseCubit.get(context).currentIndex],
         /* ConditionalBuilder(
            condition: BrowiseCubit.get(context).model !=null,
            builder: (context){
              return Column(
                children: [
                  if(!BrowiseCubit.get(context).model!.isEmailVrefied!)
                  /*Container(
                      height: 50,
                      color: Colors.amber.withOpacity(0.5),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,color: Colors.red,),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Text('please verfiy your email',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red
                                ),
                              ),
                            ),
                            SizedBox(width:50),
                            defaultTextButton(
                                onpress: (){
                                  FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value){
                                    Fluttertoast.showToast(
                                      msg: 'Please check your mail',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 5,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }).catchError((error){
                                    Fluttertoast.showToast(
                                      msg: 'ERROR',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 5,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  });
                                },
                                text: 'SEND',
                                width: 100
                            ),
                          ],
                        ),
                      )
                  ),*/
                  /*SizedBox(height:10),*/
                  BrowiseCubit.get(context).screens[BrowiseCubit.get(context).currentIndex],
                ],
              );
            },
            fallback: (context)=>Center(
              child: CircularProgressIndicator(),
            ),
          ),*/
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.white,
            selectedIconTheme:IconThemeData(
              color: Colors.white,
              size: 25
            ) ,
            unselectedIconTheme:IconThemeData(
              color: Colors.black,
              size:20
            ) ,
            backgroundColor: HexColor('#ff8800'),
            elevation: 1,
            type: BottomNavigationBarType.fixed,
            currentIndex: BrowiseCubit.get(context).currentIndex,
            onTap: (index){
              BrowiseCubit.get(context).changeNavBar(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home,size: 25,),label: 'Home' ,),
              BottomNavigationBarItem(icon: Icon(Icons.message,size: 25),label: 'chats'),
              BottomNavigationBarItem(icon: Icon(Icons.upload_file,size: 25),label: 'Post'),
              BottomNavigationBarItem(icon: Icon(Icons.location_on,size: 25),label: 'Users'),
              BottomNavigationBarItem(icon: Icon(Icons.settings,size: 25),label: 'Settings'),
            ],
          ),

        );
      },
    );
  }
}
