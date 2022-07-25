import 'package:browis_it/cubit/cubit/login_cubit/browise_it_login_cubit.dart';
import 'package:browis_it/layout/home_layout.dart';
import 'package:browis_it/modules/register/register_screen.dart';
import 'package:browis_it/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:browis_it/cubit/states/browise_login_states/browise_it_login_states.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginScreen extends StatelessWidget {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>BrowiseLoginCubit(),
      child: BlocConsumer<BrowiseLoginCubit,BrowiseLoginStates>(
        listener: (context,state){
          if(state is BrowiseLoginErrorState) {
            Fluttertoast.showToast(
              msg: '${state.error}',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }else if(state is BrowiseLoginSucessState){
            Fluttertoast.showToast(
              msg: 'Welcome  ${state.userName}',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            pageRouter(context, HomeLayout());
          }
        },
        builder: (context,state){
          return Scaffold(
            backgroundColor:Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 30,right: 30,top: 150),
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
                      Text('LOGIN' ,
                        style: TextStyle(
                            color:HexColor('000000'),
                            fontSize:30,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 5,),
                      Center(child: Text('Login To Connect With Your Best Friends All Over The World' ,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          height:2,
                          color:Colors.grey.shade500,
                          fontSize:15,
                        ),
                        textAlign: TextAlign.center,
                      ),),
                      SizedBox(height: 10,),
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
                            label: Text('E-Mail',style: TextStyle(
                              color: Colors.black
                            ),),
                            prefixIcon: Icon(Icons.email,color:HexColor('#ff8800'),),
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
                          cursorHeight: 20,
                          style: TextStyle(
                            color: Colors.black
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          controller:passwordController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:HexColor('ff8800') ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Text('Password',style: TextStyle(
                              color: Colors.black
                            ),),
                            suffixIcon:Icon(Icons.visibility),
                            prefixIcon: Icon(Icons.lock,color:HexColor('ff8800'),),
                          ),
                          onFieldSubmitted: (value){
                            if(formKey.currentState!.validate()){
                              BrowiseLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
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
                          text: 'LOGIN',
                          onpress: (){
                            if(formKey.currentState!.validate()){
                              BrowiseLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }

                          }
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20,right: 20,left: 60),
                        child:Row(
                          children: [
                            Text('Don\'t have an account?',
                            style: TextStyle(
                              color: Colors.black
                            ),
                            ),
                            TextButton(
                                onPressed: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=>BrowiseRegisterScreen()));
                                }, child:Text('Register',
                              style: TextStyle(
                                color:HexColor('ff8800'),
                              ),
                            )),
                          ],
                        ),
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