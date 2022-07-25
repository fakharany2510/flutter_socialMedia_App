import 'package:browis_it/cubit/cubit/register_cubit/browise_register_cubit.dart';
import 'package:browis_it/cubit/states/browise_register_states/browise_register_states.dart';
import 'package:browis_it/layout/home_layout.dart';
import 'package:browis_it/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
class BrowiseRegisterScreen extends StatelessWidget {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>BrowiseRegisterCubit(),
      child: BlocConsumer<BrowiseRegisterCubit,BrowiseRegisterStates>(
        listener: (context,state){
          if(state is BrowiseCreateUserSucessState){
              Fluttertoast.showToast(
                msg: 'Welcome ${state.userName} to my app',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 18.0,
              );
              pageRouter(context,HomeLayout());
          }
        },
        builder: (context,state){
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 30,right: 30,top:150),
                child:Form(
                  key: formKey,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child:Image(
                            image: AssetImage('assets/images/blogin3.png'),
                            height: 100,
                            width:100
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text('REGISTER' ,
                        style: TextStyle(
                            color:HexColor('000000'),
                            fontSize:30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left:10,right: 10,top: 20),
                        child:TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.name,
                          controller:nameController ,
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
                      Padding(padding: EdgeInsets.only(left:10,right: 10,top: 20),
                        child:TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller:emailController ,
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
                            label: Text('E-Mail'),
                            prefixIcon: Icon(Icons.email,color:HexColor('ff8800'),),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return'Please enter your e-mail';
                            }
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left:10,right: 10,top: 20),
                        child:TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.phone,
                          controller:phoneController ,
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
                      Padding(padding: EdgeInsets.only(left:10,right: 10,top: 20),
                        child:TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          controller:passwordController ,
                          decoration: InputDecoration(
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
                            label: Text('Password'),
                            suffixIcon:Icon(Icons.visibility),
                            prefixIcon: Icon(Icons.lock,color:HexColor('ff8800'),),
                          ),
                          onFieldSubmitted: (value){
                            if(formKey.currentState!.validate()){
                              BrowiseRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                              );
                            }
                          },
                          obscureText: true,
                          validator: (value){
                            if(value!.isEmpty){
                              return'Please enter your password';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 30,),
                      defaultTextButton(
                          text: 'REGISTER',
                          onpress: (){
                            if(formKey.currentState!.validate()){
                              BrowiseRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passwordController.text,
                              );
                            }

                          }
                      ),
                    ],
                  ),
                ),
              ),
            ),

          );
        },
      ),
    );
  }
}
