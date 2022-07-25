import 'package:browis_it/cubit/cubit/app_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:browis_it/cubit/cubit/login_cubit/browise_it_login_cubit.dart';
Widget defaultTextButton({
  required VoidCallback onpress,
  required String  text,
  double width =200,
  double fontSize=20,
})=>TextButton(onPressed:onpress, child: Text(text,
  style: TextStyle(
      color:HexColor('ffffff'),
      fontSize:fontSize,

  ),
),
  style:ButtonStyle(
    backgroundColor:MaterialStateProperty.all<Color>(HexColor('#ff8800')),
    fixedSize:MaterialStateProperty.all<Size>(Size.fromWidth(width)),
  ) ,);

void pageRouter(context , Widget page){
  Navigator.push(context, MaterialPageRoute(builder: (builder)=>page));
}

BrowiseCubit? browiseCubit;
