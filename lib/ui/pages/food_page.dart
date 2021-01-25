part of 'pages.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    double listItemWidth =
        MediaQuery.of(context).size.width - 2 * defaultMargin;
    return ListView(
      children: [
        Column(
          children: [
            //// HEADER
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              color: Colors.white,
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Food Market",
                        style: blackFontStyle1,
                      ),
                      Text(
                        "Let's get some foods",
                        style: greyFont.copyWith(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            // fetch profile picture dari user cubit
                            // tanpa validasi karena sudah di pastikan saat login
                            image: NetworkImage(
                                (context.bloc<UserCubit>().state as UserLoaded)
                                    .user
                                    .picturePath),
                            fit: BoxFit.cover)),
                  )
                ],
              ),
            ),

            /// LIST OF FOOD
            Container(
              height: 258,
              width: double.infinity,
              // buat blocbuilder dari foodcubit dan food state
              child: BlocBuilder<FoodCubit, FoodState>(
                // jika statenya foodloaded maka menampilkan listview
                // jika tidak maka loading idnicator
                builder: (_, state) => (state is FoodLoaded)
                    ? ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            children: state.foods // dari cubit
                                .map((e) => Padding(
                                      padding: EdgeInsets.only(
                                          left: (e == mockFoods.first)
                                              ? defaultMargin
                                              : 0,
                                          right:
                                              defaultMargin), // check jika loop pertama maka
                                      // bungkus foodcard menjadi gesturedetector
                                      child: GestureDetector(
                                          // ketika di tap
                                          onTap: () {
                                            // akan ke Widget fooddetailspage
                                            // dengan membawa parameter dari class fooddetails page tersebut
                                            Get.to(FoodDetailsPage(
                                              // food diambil dari e, sedangnkan user diambil dari cubit
                                              transaction: Transaction(
                                                  food: e,
                                                  user: (context
                                                          .bloc<UserCubit>()
                                                          .state as UserLoaded)
                                                      .user),
                                              onBackButtonPressed: () {
                                                Get.back();
                                              },
                                            ));
                                          },
                                          child: FoodCard(e)),
                                    ))
                                .toList(),
                          )
                        ],
                      )
                    : Center(child: loadingIndicator),
              ),
            ),

            /// LIST OF FOOD TABS
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  CustomTabBar(
                      selectedIndex: selectedIndex,
                      titles: ['New Taste', 'Popular', 'Recomended'],
                      onTap: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      }),
                  SizedBox(
                    height: 16,
                  ),
                  // buat bloc builder of foodcubit dan food state
                  BlocBuilder<FoodCubit, FoodState>(builder: (_, state) {
                    if (state is FoodLoaded) {
                      // menampilkan list of food berdasarkan foodtype
                      List<Food> foods = state.foods
                          .where((element) => element.types.contains(
                              (selectedIndex == 0)
                                  ? FoodType.new_food
                                  : (selectedIndex == 1)
                                      ? FoodType.pupular
                                      : FoodType.recomended))
                          .toList();
                      return Column(
                          children: foods
                              .map((e) => Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        defaultMargin, 0, defaultMargin, 16),
                                    child: FoodListItem(
                                      food: e,
                                      itemWidth: listItemWidth,
                                    ),
                                  ))
                              .toList());
                    } else {
                      return Center(
                        child: loadingIndicator,
                      );
                    }
                  }),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            )
          ],
        )
      ],
    );
  }
}
