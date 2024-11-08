import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

// Controller
class HomeController extends GetxController {
  // Use a Map to track the favorite status of each item by ID
  var favorites = <int, bool>{}.obs;

  // Toggle the favorite status for a specific item
  void toggleFavorite(int itemId) {
    favorites[itemId] = !(favorites[itemId] ?? false);
  }

  // Check if an item is favorite
  bool isFavorite(int itemId) => favorites[itemId] ?? false;

  int selectedIndex = 0;
  int selectedIndexB = 0;

  void changebottem(int index) {
    selectedIndexB = index;
    update();

    // Use GetX navigation based on selected index
    switch (selectedIndexB) {
      case 0:
        Get.offNamed("/home");
        break;
      case 1:
        Get.offNamed("/serach");
        break;
      case 2:
        Get.offNamed("/chat");
        break;
      case 3:
        Get.offNamed("/lib");
        break;
      case 4:
        Get.offNamed("/acu");
        break;
    }
  }

  void changeTab(int index) {
    selectedIndex = index;
    update(); // Notify GetX to update the UI
  }
}

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("حياك الله, فيصل",
                      style: TextStyle(color: Colors.black)),
                  SizedBox(width: 10),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/men1.webp'),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Category Tabs

                // Carousel Widget
                SectionHeader(title: "قصص مختارة لك"),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 260.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 500),
                    viewportFraction: 0.8,
                  ),
                  items: [
                    StoryCard(
                      imageUrl: 'assets/images/Card1.png',
                      title: 'قصة كوفية',
                      description: '...',
                    ),
                    StoryCard(
                      imageUrl: 'assets/images/Card2.png',
                      title: 'أبو الطيب',
                      description: '...',
                    ),
                    StoryCard(
                      imageUrl: 'assets/images/Card1.png',
                      title: 'قصة كوفية',
                      description: '...',
                    ),
                    StoryCard(
                      imageUrl: 'assets/images/Card2.png',
                      title: 'أبو الطيب',
                      description: '...',
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GetBuilder<HomeController>(
                  builder: (_) => Container(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CategoryTab(
                            title: "الكل",
                            isActive: controller.selectedIndex == 0,
                            onTap: () => controller.changeTab(0)),
                        CategoryTab(
                            title: "العلم",
                            isActive: controller.selectedIndex == 1,
                            onTap: () => controller.changeTab(1)),
                        CategoryTab(
                            title: "الشعر والأدب",
                            isActive: controller.selectedIndex == 2,
                            onTap: () => controller.changeTab(2)),
                        CategoryTab(
                            title: "القانون",
                            isActive: controller.selectedIndex == 3,
                            onTap: () => controller.changeTab(3)),
                        CategoryTab(
                            title: "التاريخ",
                            isActive: controller.selectedIndex == 4,
                            onTap: () => controller.changeTab(4)),
                        CategoryTab(
                            title: "الإسلام والمسلمين",
                            isActive: controller.selectedIndex == 5,
                            onTap: () => controller.changeTab(5)),
                      ],
                    ),
                  ),
                ),

                SectionHeader(title: "أشهر القصص"),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BookItem(
                        id: 1,
                        title: 'حكاية غزلية',
                        author: 'عنترة بن شداد',
                        imageUrl:
                            'assets/images/book1.png', // Replace with actual image URL
                      ),
                      BookItem(
                        id: 2,
                        title: 'حي بن يقظان',
                        author: 'ابن سينا',
                        imageUrl:
                            'assets/images/book2.png', // Replace with actual image URL
                      ),
                      BookItem(
                        id: 3,
                        title: 'ديوان المتنبي',
                        author: 'أبي الطيب المتنبي',
                        imageUrl:
                            'assets/images/book3.png', // Replace with actual image URL
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed("/chat");
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      "assets/images/talk.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                // ... Rest of your widgets
                SectionHeader(title: "نشاطك الأخير"),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildCustomCard(
                        cat: "الشعر والأدب",
                        title1: "اكتب شعرا",
                        title: "قصة",
                        description:
                            "اسئل المتنبي حول أشعاره وقصائده ورؤيته حول الشعر",
                        titleColor: Colors.blue,
                        backgroundColor: Colors.blue.withOpacity(0.1),
                      ),
                      const SizedBox(width: 4),
                      buildCustomCard(
                        cat: "العلوم",
                        title1: "علم الفلك",
                        title: "استشارة",
                        description:
                            "استشر جابر بن حيان للتعرف على الفلك ونوابغ هذا العالم",
                        titleColor: Colors.orange,
                        backgroundColor: Colors.orange.withOpacity(0.1),
                      ),
                      const SizedBox(width: 4),
                      buildCustomCard(
                        cat: "العلوم",
                        title1: "علم الفلك",
                        title: "استشارة",
                        description:
                            "استشر جابر بن حيان للتعرف على الفلك ونوابغ هذا العالم",
                        titleColor: Colors.orange,
                        backgroundColor: Colors.orange.withOpacity(0.1),
                      ),
                      const SizedBox(width: 4),
                      buildCustomCard(
                        cat: "العلوم",
                        title1: "علم الفلك",
                        title: "استشارة",
                        description:
                            "استشر جابر بن حيان للتعرف على الفلك ونوابغ هذا العالم",
                        titleColor: Colors.orange,
                        backgroundColor: Colors.orange.withOpacity(0.1),
                      ),
                    ],
                  ),
                ),
                SectionHeader(title: "مقتطفات رقيم"),
                QuoteCard(
                  b1: 5,
                  l1: 320,
                  r1: 10,
                  t1: 90,
                  net1: "assets/images/net2.png",
                  quote:
                      "الليل والخيل والبيداء تعرفني\nوالسيف والرمح والقرطاس والقلم",
                  author: "المتنبي",
                  gradientColors: [
                    Color(0xFFFF6633),
                    Color(0xFFFF6633),
                    Color(0xFFFE9140),
                  ],
                ),
                SizedBox(height: 20),
                QuoteCard(
                  b1: 10,
                  l1: 10,
                  r1: 300,
                  t1: 10,
                  net1: "assets/images/net1.png",
                  quote:
                      "العقل زينة، وذو العقل يشقى في النعيم بعقله\nوأخو الجهالة في الشقاوة ينعم",
                  author: "ابن سينا",
                  gradientColors: [
                    Color(0xFF33CC99).withOpacity(0.8),
                    Color(0xFF273470).withOpacity(0.8),
                    Color(0xFF273470),
                  ],
                ),
                ArticleCard(
                  category: "علوم",
                  title: "علم البصريات",
                  description:
                      "كيف اكتشف الكاميرا لتصبح أداة زمنية تحفظ ذكرياتنا ولحظاتنا",
                  imageUrl: 'assets/images/men1.webp',
                ),
                ArticleCard(
                  category: "استشارة",
                  title: "أكتب شعراً",
                  description: "أستشر المتنبي أشعارك وقصائدك رؤيتك.",
                  imageUrl: 'assets/images/men1.webp',
                ),
              ],
            ),
          ),
          bottomNavigationBar: GetBuilder<HomeController>(
            builder: (_) => BottomNavigationBar(
              currentIndex: controller.selectedIndexB,
              onTap: (index) => controller.changebottem(index),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "الرئيسية"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "تصفح"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat, size: 40), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book), label: "مكتبتي"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "حسابي"),
              ],
              selectedItemColor: Color(0xFF273570),
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  CategoryTab(
      {required this.title, this.isActive = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Chip(
          label: Text(
            title,
            style:
                TextStyle(color: isActive ? Colors.white : Color(0xFF1C274C)),
          ),
          backgroundColor: isActive ? Color(0xFF1C274C) : Colors.grey[200],
        ),
      ),
    );
  }
}

// Section Header Widget
class SectionHeader extends StatelessWidget {
  final String title;

  SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Story Card Widget
class StoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  StoryCard(
      {required this.imageUrl, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.grey[100]),
        width: 300,
        height: 300,
        padding: EdgeInsets.all(1),
        margin: const EdgeInsets.all(8.0),
        child: Container(
          height: 250,
          width: double.infinity,
          child: Image.asset(imageUrl,
              height: 150, width: double.infinity, fit: BoxFit.fill),
        ));
  }
}

// Personality Card Widget
class PersonalityCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  PersonalityCard({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        width: 200,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              height: 150,
              width: 200,
              child: Image.asset(imageUrl, fit: BoxFit.fill),
            ),
            SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Recent Activity Card Widget
Widget buildCustomCard({
  required String title,
  required String cat,
  required String title1,
  required String description,
  required Color titleColor,
  required Color backgroundColor,
}) {
  return Container(
    width: 200,
    height: 220,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title section
            Row(
              children: [
                Container(
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    width: 50,
                    child: Image.asset("assets/images/Bi1.png"))
              ],
            ),

            const SizedBox(height: 8),
            // Description section
            Text(
              title1,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4,
            ),

            // Description section
            Text(
              description,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                // Date section
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    cat,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// Article Card Widget
class ArticleCard extends StatelessWidget {
  final String category;
  final String title;
  final String description;
  final String imageUrl;

  ArticleCard(
      {required this.category,
      required this.title,
      required this.description,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Image.asset(imageUrl, height: 60, width: 60, fit: BoxFit.cover),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(category, style: TextStyle(color: Colors.blue)),
                    SizedBox(width: 8),
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 4),
                Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widgets for each component
class QuoteCard extends StatelessWidget {
  final String quote;
  final String author;
  final List<Color> gradientColors;
  final double t1;
  final double l1;
  final double r1;
  final double b1;
  final String net1;

  const QuoteCard({
    Key? key,
    required this.quote,
    required this.author,
    required this.gradientColors,
    required this.t1,
    required this.l1,
    required this.r1,
    required this.b1,
    required this.net1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
        ),
        Positioned(
          top: 40,
          left: 10,
          right: 10,
          child: Text(
            quote,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                height: 1.5,
                fontWeight: FontWeight.w500),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 145,
          right: 180,
          child: Container(
            height: 25,
            width: 22,
            decoration: BoxDecoration(
                color: const Color.fromARGB(70, 255, 255, 255),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  author,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(Icons.book, color: Colors.white70, size: 18),
              ],
            ),
          ),
        ),
        Positioned(
            top: t1,
            left: l1,
            right: r1,
            bottom: b1,
            child: Container(
              height: 40,
              width: 80,
              child: Image.asset(
                net1,
                fit: BoxFit.fill,
              ),
            )),
      ],
    );
  }
}

class BookItem extends StatelessWidget {
  final int id; // Add an ID to identify each item uniquely
  final String title;
  final String author;
  final String imageUrl;

  final HomeController favoriteController = Get.put(HomeController());

  BookItem({
    Key? key,
    required this.id, // Pass a unique ID for each BookItem
    required this.title,
    required this.author,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        margin: EdgeInsets.all(5),
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Obx(() => IconButton(
                        icon: Icon(
                          favoriteController.isFavorite(id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favoriteController.isFavorite(id)
                              ? Colors.red
                              : Colors.white,
                        ),
                        onPressed: () {
                          favoriteController.toggleFavorite(id);
                        },
                      )),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  author,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.edit_outlined,
                  size: 12,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
