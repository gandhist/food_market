part of 'pages.dart';

class AddressPage extends StatefulWidget {
  final User user;
  final String password;
  final File pictureFile;
  AddressPage(this.user, this.password, this.pictureFile);
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  bool isLoading = false;
  List<String> cities;
  String selectedCity;
  @override
  void initState() {
    super.initState();
    cities = [
      'Palembang',
      'Jakarta',
      'Bandung',
      'Surabaya',
      'Bali',
      'Makassar',
      'Jayapura'
    ];
    selectedCity = cities[0];
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: "Address",
      subTitle: "Make sure it's valid",
      onBackButtonPressed: () {
        Get.back();
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            child: Text(
              "Phone Number",
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
                controller: phoneController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: greyFont,
                    hintText: 'Type your phone number'),
              )),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            child: Text(
              "Address",
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
                controller: addressController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: greyFont,
                    hintText: 'Type your address'),
              )),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            child: Text(
              "House Number",
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
                controller: houseController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: greyFont,
                    hintText: 'Type your password'),
              )),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            child: Text(
              "City",
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
              child: DropdownButton(
                  isExpanded: true,
                  value: selectedCity,
                  underline: SizedBox(),
                  items: cities
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (item) {
                    setState(() {
                      selectedCity = item;
                    });
                  })),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 24),
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: (isLoading == true)
                  ? Center(
                      child: loadingIndicator,
                    )
                  : RaisedButton(
                      onPressed: () async {
                        User user = widget.user.copyWith(
                            phoneNumber: phoneController.text,
                            address: addressController.text,
                            houseNumber: houseController.text,
                            city: selectedCity);
                        setState(() {
                          isLoading = true;
                        });

                        await context.bloc<UserCubit>().signUp(
                            user, widget.password,
                            pictureFile: widget.pictureFile);

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
                      child: Text("Sign Up Now",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)))),
        ],
      ),
    );
  }
}
