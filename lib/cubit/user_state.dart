part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

// handle jika user berhasil di loaded, class ini di panggil di user cubit
class UserLoaded extends UserState {
  final User user;

  UserLoaded(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

// handle jika loading user gagal, method ini di panggil di user cubit
class UserLoadingFailed extends UserState {
  final String message;

  UserLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
