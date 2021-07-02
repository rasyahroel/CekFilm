part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int bottomNavBarIndex;
  MainPage({this.bottomNavBarIndex = 0});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController;

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  CurvedNavigationBarState navBarState = CurvedNavigationBarState();
  @override
  void initState() {
    super.initState();

    navBarState = _bottomNavigationKey.currentState;

    _page = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: _page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackPrimary,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.movie, size: 30),
          Icon(Icons.mark_chat_unread, size: 30),
          Icon(Icons.local_movies_outlined, size: 30),
          Icon(Icons.account_circle, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: yellowPrimary,
        backgroundColor: blackPrimary,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          // Get.put(AuthController()).logout();
          setState(() {
            _page = index;
            pageController.animateToPage(index,
                duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
          });
        },
        letIndexChange: (index) => true,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            final CurvedNavigationBarState navBarState =
                _bottomNavigationKey.currentState;
            navBarState.setPage(index);
            _page = index;
          });
        },
        children: <Widget>[
          HomePage(),
          MyReviewPage(),
          NobarPage(),
          ProfilePage()
        ],
      ),
    );
  }
}
