abstract class BrowiseStates{}

class BrowiseGetUserInitialState extends BrowiseStates{}

class BrowiseGetUserLoadingState extends BrowiseStates{}

class BrowiseGetUserSuccessState extends BrowiseStates{}

class BrowiseGetUserErrorState extends BrowiseStates{
  final String error;

  BrowiseGetUserErrorState(this.error);
}
//get all users
class BrowiseGetAllUsersLoadingState extends BrowiseStates{}

class BrowiseGetAllUsersSuccessState extends BrowiseStates{}

class BrowiseGetAllUsersErrorState extends BrowiseStates{
  final String error;

  BrowiseGetAllUsersErrorState(this.error);
}
//Posts
class BrowiseGetPostsLoadingState extends BrowiseStates{}

class BrowiseGetPostsSuccessState extends BrowiseStates{}

class BrowiseGetPostsErrorState extends BrowiseStates{
  final String error;

  BrowiseGetPostsErrorState(this.error);
}
//Likes
class BrowiseGetLikesLoadingState extends BrowiseStates{}

class BrowiseGetLikesSuccessState extends BrowiseStates{}

class BrowiseGetLikesErrorState extends BrowiseStates{
  final String error;

  BrowiseGetLikesErrorState(this.error);
}
//--------------------------
class BrowiseChangeBottomNavBarState extends BrowiseStates{}

class BrowiseNewPostState extends BrowiseStates{}

class ChangerCoverImageSuccessState extends BrowiseStates{}

class ChangerCoverImageErrorState extends BrowiseStates{}

class ChangerProfileImageSuccessState extends BrowiseStates{}

class ChangerProfileImageErrorState extends BrowiseStates{}

class UpdateProfileImageSuccessState extends BrowiseStates{}

class UpdateProfileImageErrorState extends BrowiseStates{}

class UpdateCoverImageSuccessState extends BrowiseStates{}

class UpdateCoverImageErrorState extends BrowiseStates{}

class UpdateUserDataLoadingState extends BrowiseStates{}

class UpdateUserDataErrorState extends BrowiseStates{}

//post
class ChangerPostImageSuccessState extends BrowiseStates{}

class ChangerPostImageErrorState extends BrowiseStates{}


class BrowiseCreatePostLoadingState extends BrowiseStates{}

class BrowiseCreatePostSuccessState extends BrowiseStates{}

class BrowiseCreatePostErrorState extends BrowiseStates{}

class BrowiseRemovePostImageSuccessState extends BrowiseStates{}

//Message States
class BrowiseSendMessageSuccessState extends BrowiseStates{}
class BrowiseSendMessageErrorState extends BrowiseStates{}
class BrowiseGetMessageSuccessState extends BrowiseStates{}
class BrowiseGetMessageErrorState extends BrowiseStates{}


