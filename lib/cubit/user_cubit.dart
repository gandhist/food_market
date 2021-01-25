import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_market/models/models.dart';
import 'package:food_market/services/services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

// fungsi signin dengan memanggil class service api
  Future<void> signIn(String email, String password) async {
    ApiReturnValue<User> result = await UserServices.signIn(email, password);
    // jika result null maka akan emit class yang ada di user state cubit
    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserLoadingFailed(result.message));
    }
  }

  // fungsi untuk signup
  Future<void> signUp(User user, String password, {File pictureFile}) async {
    // api return value of user
    ApiReturnValue<User> result =
        await UserServices.signUp(user, password, pictureFile: pictureFile);

    // jika hasil dari request ke userservices tidak null
    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserLoadingFailed(result.message));
    }
  }

  // fngsi untuk upload profile pictures
  Future<void> uploadProfilePicture(File pictureFile) async {
    // api return value of string
    ApiReturnValue<String> result =
        await UserServices.uploadProfilePicture(pictureFile);
    if (result.value != null) {
      // emit dengan merubah state userloaded
      emit(UserLoaded((state as UserLoaded)
          .user
          .copyWith(picturePath: baseUrl + "/storage/" + result.value)));
    } else {}
  }
}
