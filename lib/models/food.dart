part of 'models.dart';

enum FoodType { new_food, pupular, recomended }

// equatable berfungsi untuk pengujian
class Food extends Equatable {
  final int id;
  final String picturePath;
  final String name;
  final String description;
  final String ingredients;
  final int price;
  final double rate;
  final List<FoodType> types;

// constructors
  Food(
      {this.id,
      this.picturePath,
      this.name,
      this.description,
      this.ingredients,
      this.price,
      this.rate,
      this.types = const []});

  @override
  // TODO: implement props
  List<Object> get props =>
      [id, picturePath, name, description, ingredients, price, rate];
}

// mockfood atau dummy
List<Food> mockFoods = [
  Food(
      id: 1,
      picturePath:
          "https://www.indoindians.com/wp-content/uploads/2016/03/Sate-Ayam-768x512.jpg",
      name: "Sate Ayam",
      description:
          "This is probably the most popular Indonesian dish: chicken, lamb or beef chunks in skewers, grilled, and topped with peanut sauce – satay (or sate in Indonesian)",
      ingredients: "Onion, Nutshell, etc",
      price: 22000,
      types: [FoodType.new_food],
      rate: 4.6),
  Food(
      id: 1,
      picturePath:
          "https://akcdn.detik.net.id/community/media/visual/2019/08/12/dca21bf3-923c-486f-bc2e-a3dcd759b1df.jpeg?w=700&q=90",
      name: "Bakso",
      description:
          "This is probably the most popular Indonesian dish: chicken, lamb or beef chunks in skewers, grilled, and topped with peanut sauce – satay (or sate in Indonesian)",
      ingredients: "Onion, Nutshell, etc",
      price: 18000,
      types: [FoodType.new_food],
      rate: 3.6),
  Food(
      id: 1,
      picturePath:
          "https://ecs7.tokopedia.net/img/cache/700/attachment/2019/4/30/15565788818351/15565788818351_b143ce04-18e5-4a5d-8d60-f3a31ab9354d.png",
      name: "Pempek Adaan",
      description:
          "Pempek adaan adalah salah satu varian pempek yang paling diminati di palembang, dengan bentuk nya yang bulat dan rasa ikan yang sangat khas membuat makanan ini menjadi primadona banyak orang",
      ingredients: "Onion, Nutshell, etc",
      price: 5000,
      types: [FoodType.pupular],
      rate: 3.6),
  Food(
      id: 1,
      picturePath:
          "https://www.indoindians.com/wp-content/uploads/2016/03/Sate-Ayam-768x512.jpg",
      name: "Lontong Sate",
      description:
          "This is probably the most popular Indonesian dish: chicken, lamb or beef chunks in skewers, grilled, and topped with peanut sauce – satay (or sate in Indonesian)",
      ingredients: "Onion, Nutshell, etc",
      price: 17000,
      types: [FoodType.recomended],
      rate: 2.6)
];
