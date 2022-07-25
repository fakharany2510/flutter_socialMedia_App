import 'package:browis_it/cubit/cubit/app_cubit.dart';
import 'package:browis_it/cubit/states/app_states.dart';
import 'package:browis_it/models/create_post_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrowiseCubit,BrowiseStates>(
      builder: (context , state){
        return  ConditionalBuilder(
          condition:BrowiseCubit.get(context).posts.length > 0,
          builder:(context)=>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  margin:EdgeInsets.all(10) ,
                  clipBehavior:Clip.antiAliasWithSaveLayer,
                  elevation: 15,
                  child: Stack(
                    alignment:AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                          image: NetworkImage('${BrowiseCubit.get(context).userModel!.image}')
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Commuicate with friends',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:16
                          ),
                        ),
                      )
                    ],

                  ),
                ),
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context , index)=>buidPostItem(BrowiseCubit.get(context).posts[index],context,index),
                  itemCount:BrowiseCubit.get(context).posts.length,
                  separatorBuilder: (context,index)=>SizedBox(height: 5,),
                )
              ],
            ),
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator())
        );
      },
      listener: (context,state){},
    );
  }










  //-----------------------------------post item
  Widget buidPostItem(BrowisePostModel model ,context , index)=>Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Card(
      margin:EdgeInsets.symmetric(horizontal: 10) ,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('${BrowiseCubit.get(context).userModel!.image}'),
                  radius: 30,
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${model.name}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(width: 5,),
                          Icon(Icons.check_circle,color: Colors.blue,size:15,)
                        ],
                      ),
                      Text('${model.dateTime}',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade300,
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('${model.text}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                )),
           //HASHTAGS
           /* Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 10),
              child: Wrap(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(end:5.0),
                    child: Container(
                      height: 25,
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){},
                        minWidth: 1,
                        child: Text('#Software',style: TextStyle(
                          color: Colors.blue,
                        ),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(end:5.0),
                    child: Container(
                      height: 25,
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){},
                        minWidth: 1,
                        child: Text('#Flutter',style: TextStyle(
                          color: Colors.blue,
                        ),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(end:5.0),
                    child: Container(
                      height: 25,
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){},
                        minWidth: 1,
                        child: Text('#Mobile_Development',style: TextStyle(
                          color: Colors.blue,
                        ),),
                      ),
                    ),
                  ),

                ],
              ),
            ),*/
            if(model.postImage != '')
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  image: DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    print('like');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.favorite_border_outlined,color: Colors.red,),
                        SizedBox(width:5),
                        Text('${BrowiseCubit.get(context).likes[index]}',style: TextStyle(
                          color: Colors.grey,
                        ),)
                      ],
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: (){
                    print('like');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.chat_bubble_outline,color: Colors.red,),
                        SizedBox(width:5),
                        Text('0 comment',style: TextStyle(
                          color: Colors.grey,
                        ),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade300,
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    print('writing a comment..');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage('${BrowiseCubit.get(context).userModel!.image}'),
                          radius: 15,
                        ),
                        SizedBox(width: 15,),
                        Text('write a comment....'),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: (){
                    BrowiseCubit.get(context).likePosts(BrowiseCubit.get(context).postsId[index]);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.favorite_border_outlined,color: Colors.red,),
                      SizedBox(width:5),
                      Text('Like',style: TextStyle(
                        color: Colors.grey,
                      ),)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
