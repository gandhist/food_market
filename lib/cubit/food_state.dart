part of 'food_cubit.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodInitial extends FoodState {}

// method state jika berhasil
class FoodLoaded extends FoodState {
  final List<Food> foods;
  FoodLoaded(this.foods);

  @override
  // TODO: implement props
  List<Object> get props => [foods];
}

// method state jika fail
class FoodLoadedFailed extends FoodState {
  final String message;
  FoodLoadedFailed(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
