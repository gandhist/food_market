part of 'pages.dart';

class SuccessSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IllustrationPage(
          title: "Yeay! Completed",
          subtitle: "Now you are able to order \n some foods as a self reward",
          picturePath: "assets/food_wishes.png",
          buttonTap1: () {},
          buttonTitle1: "Find Foods"),
    );
  }
}
