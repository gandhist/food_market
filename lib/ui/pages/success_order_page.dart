part of 'pages.dart';

class SuccessOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IllustrationPage(
        title: "You've Made Order",
        subtitle: "Just stay at home while we are \n preparing your best food",
        picturePath: "assets/bike.png",
        // order other food
        // redirect ke main page
        buttonTap1: () {
          Get.offAll(MainPage());
        },
        buttonTitle1: "Order other foods",
        buttonTap2: () {
          Get.offAll(MainPage(initialPage: 1));
        },
        buttonTitle2: "View my order",
      ),
    );
  }
}
