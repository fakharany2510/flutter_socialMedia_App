import 'package:browis_it/provider_concepts/provider/provider.dart';
import 'package:browis_it/shared/components.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
class ProviderUi extends StatelessWidget {
    String  name='ahmed';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>Model(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Provider'),
        ),
        body: Consumer<Model>(builder: ((context, Model, child){
          return Center(
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Text('${Model.name}',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600
                    )),
                defaultTextButton(onpress:(){
                  Model.changUserName();
                }, text: 'change name')
              ],
            ),
          );
        })),
      ) ,
    );
  }
}