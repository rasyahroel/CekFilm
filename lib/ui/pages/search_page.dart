part of 'pages.dart';

class SearchMoviePage extends StatefulWidget {
  @override
  _SearchMoviePageState createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  String searchKey = '';
  TextEditingController tSearch = TextEditingController();
  String hintSearch = "Cari...";
  int page = 1;
  MovieController movieController = Get.put(MovieController());
  final ScrollController scrollController = ScrollController();
  var isSearching = false;

  @override
  void initState() {
    super.initState();
    // fetchData();
    // filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          page++;
          movieController.getMoreMovie(tSearch.text, page);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    return Scaffold(
      backgroundColor: blackPrimary,
      body: SafeArea(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            //Header searchbar
            makeSearchHeader(),
            //Header menu
            //Body
            buildListMovie()
          ],
        ),
      ),
    );
  }

  Widget makeSearchHeader() {
    return SliverFixedExtentList(
      itemExtent: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? MediaQuery.of(context).size.height * 0.12
          : MediaQuery.of(context).size.height * 0.20,
      delegate: SliverChildListDelegate([
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          color: blackPrimary,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8)),
              child: TextField(
                onChanged: (text) {
                  if (text.isEmpty) {
                    setState(() {
                      isSearching = false;
                    });
                  }
                },
                style: whiteTextFont,
                controller: tSearch,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  movieController.getSearchMovie(tSearch.text, page);

                  setState(() {
                    isSearching = true;
                  });
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    labelStyle: whiteTextFont,
                    hintText: "Search....",
                    hintStyle: whiteTextFont,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackPrimary),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackPrimary),
                        borderRadius: BorderRadius.circular(10.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: blackPrimary),
                        borderRadius: BorderRadius.circular(8))),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget buildListMovie() {
    // final fbs = FloatingSearchBar.of(context);
    if (!isSearching) {
      return SliverFillRemaining(
          child: Container(
        width: Get.width,
        color: blackPrimary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/search.json',
              width: Get.width * 0.45,
            ),
            Text(
              'Mau cari apa nih ?',
              style: whiteTextFont.copyWith(
                  fontSize: Get.height * 0.03, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ));
    } else {
      return Obx(() => isSearching &&
              movieController.searchList.length == 0 &&
              !movieController.isLoading.value
          ? SliverFillRemaining(
              child: Center(
                  child: Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin * 3),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Lowongan yang anda cari tidak ada",
                    style: blackTextFont.copyWith(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )))
          : SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
              if (index < movieController.searchList.length) {
                return Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: SearchCard(
                    movieController.searchList[index],
                    onTap: () {
                      movieController.fetchDetailMovie(
                          movieController.searchList[index].id.toString());
                    },
                  ),
                );
              } else {
                return _loadingIndicator();
              }
            },
                  childCount: movieController.searchList.length +
                      (!movieController.isLoading.value &&
                              movieController.isMoreDataAvailable.value
                          ? 1
                          : 0))));
    }
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Center(
          child: CircularProgressIndicator(
        backgroundColor: yellowPrimary,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
      )),
    );
  }
}
