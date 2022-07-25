import 'package:browis_it/cubit/cubit/app_cubit.dart';
import 'package:browis_it/cubit/states/app_states.dart';
import 'package:browis_it/modules/edit_profile/edit_profile_screen.dart';
import 'package:browis_it/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrowiseCubit , BrowiseStates>(
      listener: (context,state){
        if(state is BrowiseGetUserSuccessState){
          BrowiseCubit.get(context).getUserData();
        }
      },
      builder: (context,state){
        var model=BrowiseCubit.get(context).userModel;
        return  SingleChildScrollView(
            child: Column(
              children: [
                //profile
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    child: Stack(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                image: DecorationImage(
                                    image: NetworkImage('${model!.cover}'),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 57,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage('${model.image}'),
                            radius: 55,
                          ),
                        ),
                      ],
                    ),
                  ),

                ),
                //name
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${model.name}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(width: 5,),
                    Icon(Icons.check_circle,color: Colors.blue,size:15,)
                  ],
                ),
                SizedBox(height:15),
                //bio
                Text('${model.bio}',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                  ),),
                Padding(
                  padding: const EdgeInsets.only(left: 30,bottom: 20,top: 25,right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text(
                              '25',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            Text(
                              'Posts',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 40,),
                      InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text(
                              '331',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 40,),
                      InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text(
                              '1,123',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            Text(
                              'Following',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                defaultTextButton(
                  text: 'Edit Profile',
                  onpress: ()
                  {
                    pageRouter(context, EditProfileScreen());
                  },
                  width: 100,
                  fontSize: 15,
                ),
              ],
            ),
          );

      },

    );
  }
}
