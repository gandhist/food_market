part of 'pages.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  int selectedIndex = 0;
  // List<Transaction> inProgress =  ;
  //// past order
  // List<Transaction> past = ;
  @override
  Widget build(BuildContext context) {
    // bloc builder transaction cubit
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (_, state) {
        if (state is TransactionLoaded) {
          // jika tidak ada transaksi
          if (state.transaction.length == 0) {
            return IllustrationPage(
                title: 'Ouch! Hungry?',
                subtitle: 'Seems you like have no \n ordered any food yet',
                picturePath: 'assets/love_burger.png',
                buttonTap1: () {},
                buttonTitle1: 'Find Foods');
          } else {
            // jika ada transaksi
            double listItemWidht =
                MediaQuery.of(context).size.width - 2 * defaultMargin;
            return ListView(children: [
              Column(
                children: [
                  //// HEADER
                  Container(
                    height: 100,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: defaultMargin),
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("your Order", style: blackFontStyle1),
                        Text(
                          "Wait for the best meal",
                          style: greyFont.copyWith(fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                  //// BODY
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        CustomTabBar(
                          selectedIndex: selectedIndex,
                          titles: ["In Progress", "Past Orders"],
                          onTap: (index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        Builder(
                          builder: (_) {
                            List<Transaction> transaction = (selectedIndex == 0)
                                ? state.transaction
                                    .where((element) =>
                                        element.status ==
                                            TransactionStatus.on_delivery ||
                                        element.status ==
                                            TransactionStatus.pending)
                                    .toList()
                                :
                                // jika tidak maka menampilkan pesanan transaksi yang sudah pernah di lakukan
                                state.transaction
                                    .where((element) =>
                                        element.status ==
                                            TransactionStatus.delivered ||
                                        element.status ==
                                            TransactionStatus.cancelled)
                                    .toList();
                            return Column(
                              // jika selected index 0 atau sedang ada di tab ada pesanan
                              // maka akan menampilkan transactionn yang status delivery or pending
                              children: (transaction)
                                  // di jadikan map biar di looping dengan fungsi map
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.only(
                                            right: defaultMargin,
                                            left: defaultMargin,
                                            bottom: 16),
                                        child: OrderListItem(
                                          transaction: e,
                                          itemWidth: listItemWidht,
                                        ),
                                      ))
                                  .toList(),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ]);
          }
        } else {
          return Center(
            child: loadingIndicator,
          );
        }
      },
    );
  }
}
