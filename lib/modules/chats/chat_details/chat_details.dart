import 'package:browis_it/cubit/cubit/app_cubit.dart';
import 'package:browis_it/cubit/states/app_states.dart';
import 'package:browis_it/models/message_model.dart';
import 'package:browis_it/models/new_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class ChatDetails extends StatelessWidget {
   BrowiseUserModel userModel;
  ChatDetails({required this.userModel});
  TextEditingController textMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      builder: (context)=>Builder(
        builder: (context) {
          BrowiseCubit.get(context).getMessages(recevierId: userModel.userId!);
          return BlocConsumer<BrowiseCubit,BrowiseStates>(
            listener: (context,state){},
            builder: (context,state){
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.amber.shade900,
                  elevation: 0,
                  centerTitle: true,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('${userModel.image}') as ImageProvider,
                        radius: 25,
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('${userModel.name}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),

                              ],
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                body: ConditionalBuilder(
                  builder: (context)=>Stack(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    children: [
                      Container(
                        color: Colors.amber.shade900,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50,left: 10,right: 10),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                      itemBuilder: (context , index)
                                      {
                                        var message =BrowiseCubit.get(context).messages[index];
                                        if(userModel.userId == message.senderId)
                                         //send message
                                          return builsRecievedMessages(message);
                                        //receive message
                                         return buildMyMessages(message);


                                        //


                                      },
                                      separatorBuilder: (context , index)=>SizedBox(height: 15,),
                                      itemCount: BrowiseCubit.get(context).messages.length),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.amber.shade900,
                                          width: 1
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8),
                                            child: TextFormField(
                                              controller: textMessage,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'type your message...',

                                              ),
                                            ),
                                          ),
                                        ),
                                        // Spacer(),
                                        MaterialButton(onPressed: (){
                                          BrowiseCubit.get(context).sendMessage(
                                              recevierId: userModel.userId!,
                                              dateTime: DateTime.now().toString(),
                                              text: textMessage.text);
                                        },
                                          height: 50,
                                          color: Colors.amber.shade900,
                                          child: Icon(
                                              Icons.arrow_forward_ios
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  condition:BrowiseCubit.get(context).messages.length >0 ,
                  fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                ),
              );
            },
          );
        }
      ),
      condition: userModel !=null,
      fallback: (context)=>Center(child: CircularProgressIndicator()),
    );
  }
  Widget buildMyMessages(MessageModel model)=> Align(
    alignment:AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.amber.shade900,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Text('${model.text}',
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15
        ),
      ),
    ),
  );
  //----------------------------
Widget builsRecievedMessages(MessageModel model)=>Align(
  alignment:AlignmentDirectional.centerStart,
  child: Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
    ),
    child: Text('${model.text}',
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15
      ),
    ),
  ),
);
}
