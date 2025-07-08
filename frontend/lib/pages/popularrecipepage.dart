import 'package:flutter/material.dart';
import 'package:sri_cuisine/models/popularrecipe.dart';
import 'package:iconsax/iconsax.dart';

class PopularRecipePage extends StatefulWidget {
  final PopularRecipe popularrecipe;
  const PopularRecipePage({super.key, required this.popularrecipe});

  @override
  State<PopularRecipePage> createState() => _PopularRecipePageState();
}

class _PopularRecipePageState extends State<PopularRecipePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        // physics: const BouncingScrollPhysics(),
        children: [
          // Section 1 - Recipe Image
          GestureDetector(
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.popularrecipe.image),
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
                        "${widget.popularrecipe.cal} Cal",
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
                        "${widget.popularrecipe.time} min",
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
                        "${widget.popularrecipe.servings} servings",
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
                    widget.popularrecipe.name,
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
                          "Dish Type: ${widget.popularrecipe.course}",
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
                      "Allergens: ${widget.popularrecipe.allergens}",
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
                  fontSize: 16),
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
                      widget.popularrecipe.ingredients,
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
                      widget.popularrecipe.instructions,
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
