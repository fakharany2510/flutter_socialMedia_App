import 'package:browis_it/models/create_post_model.dart';
import 'package:browis_it/models/message_model.dart';
import 'package:browis_it/models/new_user_model.dart';
import 'package:browis_it/modules/chats/chats.dart';
import 'package:browis_it/modules/feeds/feeds.dart';
import 'package:browis_it/modules/new_posts/new_posts.dart';
import 'package:browis_it/modules/settings/setting.dart';
import 'package:browis_it/modules/users/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:browis_it/cubit/states/app_states.dart';
import 'package:bloc/bloc.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class BrowiseCubit extends Cubit<BrowiseStates>{
    BrowiseCubit() :super(BrowiseGetUserInitialState()) ;
    static BrowiseCubit get(context)=>BlocProvider.of(context);


// Getting User Data
    BrowiseUserModel? userModel;
    MessageModel? messageModel;
    void getUserData(){
        emit(BrowiseGetUserLoadingState());
        FirebaseFirestore.instance.collection('users')
            .doc('4s5NISaDrWRaJZMr88JveYk6j343')
            .get()
            .then((value){
              print(value.data());
              userModel = BrowiseUserModel.fromJson(value.data()!);
                emit(BrowiseGetUserSuccessState());
        })
            .catchError((error){
                emit(BrowiseGetUserErrorState(error));
        });
    }
//bottom nav bar
int currentIndex=0;
List<Widget> screens=[
  FeedsScreen(),
  ChatsScreen(),
  NewPosts(),
  UsersScreen(),
  SettingScreen(),
];
List<String> titles=[
  'Home',
  'Chats',
  'new posts',
  'Users',
  'Settings',
];

void changeNavBar(int index){
  if(index ==1)
    getUsers();
  if(index ==2)
    emit(BrowiseNewPostState());
  else{
    currentIndex=index;
    emit(BrowiseChangeBottomNavBarState());

  }
}
//-------------------------------------------------------------
//image picker
   var picker = ImagePicker() ;
  // Pick an image
   File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile  = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
     coverImage=File(pickedFile.path);
     emit(ChangerCoverImageSuccessState());
    } else {
      print('no coverImage selected');
      emit(ChangerCoverImageErrorState());
    }
  }
//------------------------------------------------------------
  // Pick an image
  File? profileImage;
  Future<void> getProfileImage() async {
    final pickedFile  =
    await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage=File(pickedFile.path);
      emit(ChangerProfileImageSuccessState());
    } else {
      print('no profileImage selected');
      emit(ChangerProfileImageErrorState());
    }
  }
//-------------------------------------------------------------
  //upload & update profile image
void uploadProfileImage({
  required String name,
  required String phone,
  required String bio,
}){
    //كدا انا بكريت instance من ال storage
  firebase_storage.FirebaseStorage.instance
  //كدا بقوله انا فين في الstorage
      .ref()
  //كدا بقةله هتحرك ازاي جوا ال storage
  //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
      .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
  //كدا بعمل رفع للصوره
      .putFile(profileImage!).then((value){
        value.ref.getDownloadURL().then((value){
          emit(UpdateProfileImageSuccessState());
          updateUserProfile(
            name: name,
            phone: phone,
            bio: bio,
            profile: value,
          );
        }).catchError((error){
          emit(UpdateProfileImageErrorState());
        });
  }).catchError((error){
    emit(UpdateProfileImageErrorState());
  });
}

//---------------------------------------------------------------

//upload & update cover image
  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
}){
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
    //كدا بقوله انا فين في الstorage
        .ref()
    //كدا بقةله هتحرك ازاي جوا ال storage
    //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
    //كدا بعمل رفع للصوره
        .putFile(coverImage!).then((value){
      value.ref.getDownloadURL().then((value){
        emit(UpdateCoverImageSuccessState());
        updateUserProfile(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error){
        emit(UpdateCoverImageErrorState());
      });
    }).catchError((error){
      emit(UpdateCoverImageErrorState());
    });
  }

  //--------------------------------------------------------------

//upload & update user data
void updateUserProfile({
  required String name,
  required String phone,
  required String bio,
  String? cover,
  String? profile,
}){
  emit(UpdateUserDataLoadingState());

    BrowiseUserModel model=BrowiseUserModel(
      name: name,
      phone: phone,
      bio:bio,
     cover: cover??userModel!.cover,
      isEmailVrefied: false,
      image:profile??userModel!.image,
      email: userModel!.email,
      userId:'4s5NISaDrWRaJZMr88JveYk6j343',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc('4s5NISaDrWRaJZMr88JveYk6j343')
        .update(model.toMap())
        .then((value){
      getUserData();
    })
        .catchError((error){
      emit(UpdateUserDataErrorState());
    });
  }

//-----------------------------------------------------------------
//create new post
//----
// Pick post image
  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile  =
    await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage=File(pickedFile.path);
      emit(ChangerPostImageSuccessState());
    } else {
      print('no postImage selected');
      emit(ChangerPostImageErrorState());
    }
  }
  //-------------------------------------
  //remove postimage
  void removePostImage(){
    postImage = null;
    emit(BrowiseRemovePostImageSuccessState());
  }
//upload post image
  void uploadPostImage({
     String? userId,
     String? name,
     String? image,
    required String? dateTime,
    required String? text,
  }){
    emit(BrowiseCreatePostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
    //كدا بقوله انا فين في الstorage
        .ref()
    //كدا بقةله هتحرك ازاي جوا ال storage
    //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
    //كدا بعمل رفع للصوره
        .putFile(postImage!).then((value){
      value.ref.getDownloadURL().then((value){
        createPost(
          text:text,
          dateTime: dateTime,
          postImage: value,
        );
        emit(BrowiseCreatePostSuccessState());

      }).catchError((error){
        emit(BrowiseCreatePostErrorState());
      });
    }).catchError((error){
      emit(BrowiseCreatePostErrorState());
    });
  }
//Create Post
  void createPost({
  required String? dateTime,
  required String? text,
     String? postImage,
  }){
    emit(BrowiseCreatePostLoadingState());

    BrowisePostModel model=BrowisePostModel(
      name: userModel!.name,
      image:userModel!.image,
      userId:'4s5NISaDrWRaJZMr88JveYk6j343',
      dateTime:dateTime,
      postImage:postImage??'',
      text:text,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value){
      emit(BrowiseCreatePostSuccessState());
    })
        .catchError((error){
      emit(BrowiseCreatePostErrorState());
    });
  }
  //get Posts
  List<BrowisePostModel> posts=[];
  List<String> postsId=[];
  List<int> likes=[];

  void getPosts(){
    emit(BrowiseGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference
            .collection('likes')
            .get()
            .then((value) {
              likes.add(value.docs.length);
              postsId.add(element.id);
              posts.add(BrowisePostModel.fromJson(element.data()));
            }).catchError((error){});

          });
          emit(BrowiseGetPostsSuccessState());
    }
    )
        .catchError((error){
       emit(BrowiseGetPostsErrorState(error.toString()));
    });
}
//like posts
void likePosts(String postId){
  emit(BrowiseGetLikesLoadingState());
  FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .collection('likes')
      .doc(userModel!.userId)
      .set({
    'likes':true,
  })
      .then((value){
        emit(BrowiseGetLikesSuccessState());

  })
      .catchError((error){
        emit(BrowiseGetLikesErrorState(error.toString()));
  });
}
//get all users
  late List<BrowiseUserModel> users;
void getUsers(){
  users=[];
  emit(BrowiseGetAllUsersLoadingState());
  FirebaseFirestore.instance
      .collection('users')
      .get()
      .then((value) {
    value.docs.forEach((element) {
      if(element.data()['userId'] != userModel!.userId)
      users.add(BrowiseUserModel.fromJson(element.data()));
    });
    emit(BrowiseGetAllUsersSuccessState());
  }
  )
      .catchError((error){
    emit(BrowiseGetAllUsersErrorState(error.toString()));
  });
}
//Messages
void sendMessage({
  required String recevierId,
  required String dateTime,
  required String text,
}){
  MessageModel model =MessageModel(
    recevierId:recevierId,
    senderId: userModel!.userId,
    dateTime: dateTime,
    text: text,
  );
  //Set My Chat
  FirebaseFirestore.instance
      .collection('users')
      .doc(userModel!.userId)
      .collection('chats')
      .doc(recevierId)
      .collection('messages')
      .add(model.toMap())
      .then((value){
        emit(BrowiseSendMessageSuccessState());
  })
      .catchError((error){
    emit(BrowiseSendMessageErrorState());

  });
  //Set Reciever Chat
  FirebaseFirestore.instance
      .collection('users')
      .doc(recevierId)
      .collection('chats')
      .doc(userModel!.userId)
      .collection('messages')
      .add(model.toMap())
      .then((value){
    emit(BrowiseSendMessageSuccessState());
  })
      .catchError((error){
    emit(BrowiseSendMessageErrorState());
  });
}
//get messages
  List<MessageModel> messages=[];

void getMessages({
  required String recevierId,
}){
  FirebaseFirestore.instance
      .collection('users')
      .doc(userModel!.userId)
      .collection('chats')
      .doc(recevierId)
      .collection('messages')
      .orderBy('dateTime')
      .snapshots()
      .listen((event) {
    messages = [];
        event.docs.forEach((element) {

          messages.add((MessageModel.fromJson(element.data())));
        });
        emit(BrowiseGetMessageSuccessState());
      });
}
}

