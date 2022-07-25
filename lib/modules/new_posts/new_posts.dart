import 'package:browis_it/cubit/cubit/app_cubit.dart';
import 'package:browis_it/cubit/states/app_states.dart';
import 'package:browis_it/models/create_post_model.dart';
import 'package:browis_it/shared/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class NewPosts extends StatelessWidget {
  //const NewPosts({Key? key}) : super(key: key);
TextEditingController postText=TextEditingController();
  @override
  Widget build(BuildContext context) {
      return BlocConsumer<BrowiseCubit,BrowiseStates>(
      listener: (context,state){},
        builder: (context,state){
        return Scaffold(
          appBar:AppBar(
            elevation: 0.0,
            iconTheme: IconThemeData(
                color: Colors.black
            ),
            title: Text('Add New Post',style: TextStyle(
                color: Colors.black
            ),),
            backgroundColor: Colors.white,
            titleSpacing: 0,
            actions: [
              defaultTextButton(onpress: (){
                var now=DateTime.now();
                if(BrowiseCubit.get(context).postImage == null){
                  BrowiseCubit.get(context).createPost(
                      dateTime: now.toString(),
                      text:postText.text );
                }else{
                  BrowiseCubit.get(context).uploadPostImage(
                      dateTime: now.toString(),
                      text:postText.text
                  );
                }
              }, text: 'post')
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is BrowiseCreatePostLoadingState)
                  LinearProgressIndicator(),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('https://img.freepik.com/free-photo/pretty-curly-haired-young-woman-smiles-gently-keeps-hands-together-focused-directly-camera-has-pleasant-talk-with-best-friend_273609-46056.jpg?t=st=1649688061~exp=1649688661~hmac=46e35abab9a62e7f0a5b5503f9c83486d54701b31332f77a79d7175ba0e2ca81&w=740'),
                        radius: 30,
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child:   Text('Marry James',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: postText,
                      decoration: InputDecoration(
                        hintText: 'what is on your mind.....',
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  if(BrowiseCubit.get(context).postImage != null)
                  Stack(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 300,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  image: DecorationImage(
                                      image: FileImage( BrowiseCubit.get(context).postImage!),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 20,
                                child: IconButton(onPressed: (){
                                  BrowiseCubit.get(context).removePostImage();
                                  print('change personal photo');
                                },
                                    icon: Icon(Icons.close_sharp,color:Colors.white,)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 17.0),
                        child: TextButton(onPressed: (){
                          BrowiseCubit.get(context).getPostImage();
                        }, child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt),
                            SizedBox(width:7),
                            Text('add photo')
                          ],

                        )),
                      ),
                      SizedBox(width: 140,),
                      TextButton(onPressed: (){}, child:Text('#Tags')),
                    ],
                  )
                ],
              )
          ),
        );
        },
    );
  }
}
