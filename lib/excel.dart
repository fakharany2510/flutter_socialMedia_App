import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import 'models/user.dart';

class Sheet extends StatelessWidget {
  //const Sheet({Key? key}) : super(key: key);
  //GroceryUser? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excell Sheet'),
      ),
      body: Center(
        child: TextButton(
          child: Text('Generate Excel sheet'),
          onPressed: (){
            createExcel();
          },
        ),
      ),
    );
  }
  Future<void> createExcel()async{
    String? phone;
    String? name;
    List<dynamic>? users;
    final Workbook workBook = Workbook();
    final Worksheet sheet = workBook.worksheets[0];
    await FirebaseFirestore.instance.collection('users').get().then((value){
      for(int i =0 ; i<value.docs.length ; i++){
        sheet.getRangeByName('A${i+1}').setText('${value.docs[i].data()['name']}');
        sheet.getRangeByName('B${i+1}').setText('${value.docs[i].data()['phone']}');
      }
      print('success');
    }).catchError((error){print('errrrrrrrrrrrrrrrrrror ---------->${error.toString()}');});

    print('iam here');
    final List<int> bytes = workBook.saveAsStream();
    workBook.dispose();

    final String path=(await getApplicationSupportDirectory()).path;
    final String fileName='$path/users.xlsx';
    final File file= File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);

  }
}
