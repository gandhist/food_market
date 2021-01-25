part of 'widgets.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> titles;
  final Function(int) onTap;
  CustomTabBar({@required this.selectedIndex, this.titles, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 48),
            height: 1,
            color: "F2F2F2".toColor(),
          ),
          Row(
            children: titles
                .map((e) => Padding(
                      padding: EdgeInsets.only(left: defaultMargin),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // text recomendded
                          GestureDetector(
                            onTap: () {
                              // handle jika tabbar di tap
                              if (onTap != null) {
                                // maka set function ontap
                                onTap(titles.indexOf(e));
                              }
                            },
                            child: Text(e,
                                style: (titles.indexOf(e) == selectedIndex)
                                    ? blackFontStyle3.copyWith(
                                        fontWeight: FontWeight.w500)
                                    : greyFont),
                          ),
                          Container(
                            width: 40,
                            height: 3,
                            margin: EdgeInsets.only(top: 13),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.5),
                                color: (titles.indexOf(e) == selectedIndex)
                                    ? "020202".toColor()
                                    : Colors.transparent),
                          )
                        ],
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
