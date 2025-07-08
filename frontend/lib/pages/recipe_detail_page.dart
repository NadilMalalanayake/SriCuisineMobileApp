import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sri_cuisine/models/recipe.dart';
import 'package:iconsax/iconsax.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailPage({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // Change length to 2
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _scrollController.addListener(() {
      changeAppBarColor(_scrollController);
    });
  }

  Color appBarColor = Colors.transparent;

  changeAppBarColor(ScrollController scrollController) {
    if (scrollController.position.hasPixels) {
      if (scrollController.position.pixels > 2.0) {
        setState(() {
          appBarColor = Colors.transparent;
        });
      }
      if (scrollController.position.pixels <= 2.0) {
        setState(() {
          appBarColor = Colors.transparent;
        });
      }
    } else {
      setState(() {
        appBarColor = Colors.transparent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                ),
                child: const Text("Start Cooking"),
              ),
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AnimatedContainer(
          color: appBarColor,
          duration: const Duration(milliseconds: 200),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: ListView(
        controller: _scrollController,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          // Section 1 - Recipe Image
          GestureDetector(
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://st4.depositphotos.com/4590583/26949/i/450/depositphotos_269495776-stock-photo-background-menu-dishes-top-view.jpg"),
                      fit: BoxFit.cover)),
              child: SizedBox(
                //decoration: BoxDecoration(gradient: AppColor.linearBlackTop),
                height: 280,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          // Section 2 - Recipe Info
          Container(
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.only(top: 20, bottom: 10, left: 16, right: 16),
            color: Colors.yellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recipe Calories and Time
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        "${widget.recipe.calorie} cal",
                        style: const TextStyle(
                            // color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.alarm,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        "${widget.recipe.totalTimeInMins} min",
                        style: const TextStyle(
                            // color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Icon(
                      Iconsax.user,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        "${widget.recipe.servings} servings",
                        style: const TextStyle(
                            // color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                // Recipe Title
                Container(
                  margin: const EdgeInsets.only(bottom: 16, top: 16),
                  child: Text(
                    "${widget.recipe.recipeName}",
                    style: const TextStyle(
                      //color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Recipe Description
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.dining_outlined),
                        const SizedBox(width: 5),
                        Text(
                          "Dish Type: ${widget.recipe.course}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Divider(
                  color: Colors.yellow[100],
                  thickness: 1,
                ),
                Row(
                  children: [
                    Text(
                      "Allergens: ${widget.recipe.allergens}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Tabbar ( Ingridients, Tutorial, Reviews )
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.yellow[100],
            child: TabBar(
              controller: _tabController,
              onTap: (index) {
                setState(() {
                  _tabController.index = index;
                });
              },
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black.withOpacity(0.6),
              labelStyle: const TextStyle(
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
              indicatorColor: Colors.black,
              tabs: const [
                Tab(
                  text: 'Ingridients',
                ),
                Tab(
                  text: 'Tutorial',
                ),
              ],
            ),
          ),
          // IndexedStack based on TabBar index
          IndexedStack(
            index: _tabController.index,
            children: [
              // Ingredients
              if (widget.recipe.ingredientsWithQuantites != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Ingredients",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${widget.recipe.ingredientsWithQuantites}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              // Tutorial
              if (widget.recipe.instructions != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tutorial",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${widget.recipe.instructions}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
