part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: "Sign In",
      subTitle: "Find Your best ever meal",
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            child: Text(
              "Email Address",
              style: blackFontStyle2,
            ),
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black)),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: greyFont,
                    hintText: 'Type your email address'),
              )),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            child: Text(
              "Password",
              style: blackFontStyle2,
            ),
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black)),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: greyFont,
                    hintText: 'Type your password'),
              )),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 24),
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: isLoading
                  ? loadingIndicator
                  : RaisedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await context.bloc<UserCubit>().signIn(
                            emailController.text, passwordController.text);
                        // ambil state saat ini
                        UserState state = context.bloc<UserCubit>().state;

                        // jika state bersataus user loaded
                        print(state);
                        if (state is UserLoaded) {
                          // jika berhasil maka ambil list of food dan transaction
                          context.bloc<FoodCubit>().getFoods();
                          context.bloc<TransactionCubit>().getTransaction();
                          Get.to(MainPage());
                        }
                        // jika gagal
                        else {
                          // berinotirikasi dengan snackbar
                          Get.snackbar("", "",
                              backgroundColor: "D9435E".toColor(),
                              icon: Icon(
                                MdiIcons.closeCircleMultipleOutline,
                                color: Colors.white,
                              ),
                              titleText: Text("Sign In Failed",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              messageText: Text(
                                (state as UserLoadingFailed).message,
                                style: GoogleFonts.poppins(color: Colors.white),
                              ));
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: mainColor,
                      child: Text("Sign In",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)))),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 24),
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: isLoading
                  ? SpinKitFadingCircle(
                      size: 45,
                      color: mainColor,
                    )
                  : RaisedButton(
                      onPressed: () {
                        Get.to(SignUpPage());
                      },
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: greyColor,
                      child: Text("Create new Account",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500)))),
        ],
      ),
    );
  }
}
