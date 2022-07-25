import 'package:browis_it/cubit/cubit/app_cubit.dart';
import 'package:browis_it/cubit/states/app_states.dart';
import 'package:browis_it/models/new_user_model.dart';
import 'package:browis_it/modules/chats/chat_details/chat_details.dart';
import 'package:browis_it/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:browis_it/modules/chats/chat_details/chat_details.dart';
class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrowiseCubit , BrowiseStates>(
      listener: (context , state){},
      builder: (context , state){
        return ConditionalBuilder(
            condition: BrowiseCubit.get(context).users.length>0,
          fallback: (context)=>Center(child: CircularProgressIndicator()),
          builder: (context)=>ListView.separated
            (itemBuilder: (context , index)=> buildChatItem(BrowiseCubit.get(context).users[index] , context),
              separatorBuilder: (context , index)=>Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
              itemCount: BrowiseCubit.get(context).users.length),

        );

      },
    );
  }
  Widget buildChatItem(BrowiseUserModel model , context)=>InkWell(
    splashColor: Colors.amber.shade900,
    onTap: (){
      pageRouter(context , ChatDetails(userModel: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('${model.image}'),
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

                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    ),
  );
}
