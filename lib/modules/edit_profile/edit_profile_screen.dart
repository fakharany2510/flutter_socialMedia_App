import 'package:browis_it/cubit/cubit/app_cubit.dart';
import 'package:browis_it/cubit/states/app_states.dart';
import 'package:browis_it/layout/home_layout.dart';
import 'package:browis_it/modules/settings/setting.dart';
import 'package:browis_it/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:hexcolor/hexcolor.dart';
class EditProfileScreen extends StatelessWidget {
  //const EditProfileScreen({Key? key}) : super(key: key);
  TextEditingController changeUserNameController= TextEditingController();
  TextEditingController changeUserBioController= TextEditingController();
  TextEditingController changeUserPhoneController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrowiseCubit,BrowiseStates>(
      listener: (context , state){
        /*if(state is BrowiseGetUserSuccessState)
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeLayout()));*/
      },
      builder: (context , state){
        var model = BrowiseCubit.get(context).userModel;
        var coverImage=BrowiseCubit.get(context).coverImage;
        var profileImage=BrowiseCubit.get(context).profileImage;
        changeUserNameController.text=model!.name!;
        changeUserBioController.text=model.bio!;
        changeUserPhoneController.text=model.phone!;
        return ConditionalBuilder(
          condition: model != null,
          builder: (context) => Scaffold(
            backgroundColor: Colors.grey.shade300,
            appBar:AppBar(
              elevation: 0.0,
              iconTheme: const IconThemeData(
                  color: Colors.black
              ),
              title: const Text('Edit Profile',style: TextStyle(
                  color: Colors.black
              ),),
              backgroundColor: Colors.white,
              titleSpacing: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: defaultTextButton(
                    onpress: (){
                      BrowiseCubit.get(context).updateUserProfile(
                          name:changeUserNameController.text,
                          phone:changeUserPhoneController.text,
                          bio:changeUserBioController.text);

                    },
                    text: 'Save',
                    fontSize:15,
                    width: 60,
                  ),
                ),
              ],
              automaticallyImplyLeading: true,
            ),
            body:SingleChildScrollView(
              child: Column(
                children: [
                  if(state is UpdateUserDataLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(height:10),
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
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      image: DecorationImage(
                                          image: coverImage != null ? FileImage(coverImage) :NetworkImage(model.cover) as ImageProvider ,
                                          fit: BoxFit.cover
                                      )
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 20,
                                    child: IconButton(onPressed: (){
                                      BrowiseCubit.get(context).getCoverImage();
                                      print('change personal photo');
                                    },
                                        icon: Icon(Icons.camera_alt_outlined,color:Colors.black,)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                               CircleAvatar(
                                 backgroundColor: Colors.white,
                                 radius: 57,
                                 child: CircleAvatar(
                                   backgroundImage: profileImage != null ? FileImage(profileImage) :NetworkImage(model.image) as ImageProvider,
                                   radius: 55,
                                 ),
                               ),
                               CircleAvatar(
                                 backgroundColor: Colors.white,
                                 radius: 20,
                                 child: IconButton(onPressed: (){
                                   BrowiseCubit.get(context).getProfileImage();
                                   print('change personal photo');
                                 },
                                     icon: Icon(Icons.camera_alt_outlined,color:Colors.black,)
                                 ),
                               ),

                             ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height:10),
                  if(BrowiseCubit.get(context).profileImage !=null || BrowiseCubit.get(context).coverImage !=null )
                  Row(
                    children: [
                      if(BrowiseCubit.get(context).profileImage !=null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultTextButton(
                                  text: 'Upload profile image',
                                  onpress: (){
                                    BrowiseCubit.get(context).uploadProfileImage(
                                        name:changeUserNameController.text,
                                        phone:changeUserPhoneController.text,
                                        bio:changeUserBioController.text
                                    );
                                  },
                                  width: 150,
                                  fontSize: 13
                              ),
                            ],
                          ),
                        ),
                      SizedBox(width:5),
                      if(BrowiseCubit.get(context).coverImage !=null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultTextButton(
                                  text: 'Upload cover image',
                                  onpress: (){
                                    BrowiseCubit.get(context).uploadCoverImage(
                                        name:changeUserNameController.text,
                                        phone:changeUserPhoneController.text,
                                        bio:changeUserBioController.text
                                    );
                                  },
                                  width: 150,
                                  fontSize: 13
                              ),

                            ],
                          ),
                        ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(left:10,right: 10,top: 20),
                    child:TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.name,
                      controller:changeUserNameController ,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:HexColor('ff8800')),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        label: Text('User Name',
                            style: TextStyle(
                                color: Colors.black
                            )
                        ),
                        prefixIcon: Icon(Icons.person,color:HexColor('ff8800'),),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return'Please enter your Name';
                        }
                      },
                    ),
                  ),
                  SizedBox(height:10),
                  Padding(padding: EdgeInsets.only(left:10,right: 10,top: 20),
                    child:TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.phone,
                      controller:changeUserPhoneController ,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:HexColor('ff8800')),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        label: Text('Phone'),
                        prefixIcon: Icon(Icons.phone,color:HexColor('ff8800'),),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return'Please enter your Phone';
                        }
                      },
                    ),
                  ),
                  SizedBox(height:10),
                  Padding(padding: EdgeInsets.only(left:10,right: 10,top: 20),
                    child:TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.text,
                      controller:changeUserBioController ,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:HexColor('ff8800')),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        label: Text('Bio...',
                            style: TextStyle(
                                color: Colors.black
                            )
                        ),
                        prefixIcon: Icon(Icons.beenhere,color:HexColor('ff8800'),),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return'Please enter Bio...';
                        }
                      },
                    ),
                  ),
                ],
              ),
            ) ,
          ),
          fallback: (context) => Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.shade400,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },

    );
  }
}
