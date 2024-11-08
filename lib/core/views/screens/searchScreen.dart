// File: lib/screens/explore_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class ExploreScreenController extends GetxController {
  int selectedIndexB = 1;
  int selectedIndex = 0;

  void changeTab(int index) {
    selectedIndex = index;
    update(); // Notify GetX to update the UI
  }

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
        Get.offNamed("/lib");
        break;
    }
  }

  var searchText = ''.obs;
  var categories = [
    'assets/images/cat1.png',
    'assets/images/cat2.png',
    'assets/images/cat3.png',
    'assets/images/cat4.png',
  ].obs;
  var selectedCategoryIndex = 0.obs;

  // New: Add a Map to track the favorite status of each character by index
  var favoriteStatus = <int, RxBool>{}.obs;

  // Initialize favorite status for each character (replace with real index count if needed)
  void initializeFavorites(int itemCount) {
    for (int i = 0; i < itemCount; i++) {
      favoriteStatus[i] = false.obs; // Initial state is not favorite
    }
  }

  // Toggle favorite status for a specific character index
  void toggleFavorite(int index) {
    if (favoriteStatus.containsKey(index)) {
      favoriteStatus[index]!.value = !favoriteStatus[index]!.value;
    }
  }
}

class ExploreScreen extends StatelessWidget {
  final ExploreScreenController controller = Get.put(ExploreScreenController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/men1.webp"),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "حياك الله، فيصل",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'بحث',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (value) {
                          controller.searchText.value = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GetBuilder<ExploreScreenController>(
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
                                title: "المفردات العربية",
                                isActive: controller.selectedIndex == 1,
                                onTap: () => controller.changeTab(1)),
                            CategoryTab(
                                title: "المرادفات والأضداد",
                                isActive: controller.selectedIndex == 2,
                                onTap: () => controller.changeTab(2)),
                            CategoryTab(
                                title: "الشخصيات",
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
                    SizedBox(
                      height: 8,
                    ),
                    Obx(
                      () => SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.categories.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                controller.selectedCategoryIndex.value = index;
                              },
                              child: Container(
                                width: 100,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    controller.categories[index],
                                    fit: BoxFit.fill,
                                    width: 140,
                                    height: 100,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 600,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'شخصيات منتقاة لك',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 500,
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    CharacterTile(
                                        imagePath: 'assets/images/man3.webp',
                                        title: 'جابر بن حيان',
                                        category: 'العلوم والكيمياء',
                                        time: 'ساعة',
                                        index: 0),
                                    CharacterTile(
                                      imagePath: 'assets/images/man2.png',
                                      title: 'بن سينا',
                                      category: 'الطب والفلسفة',
                                      time: 'ساعة',
                                      index: 1,
                                    ),
                                    CharacterTile(
                                      imagePath: 'assets/images/man.png',
                                      title: 'الخوارزمي',
                                      category: 'العلوم والمعرفة',
                                      time: 'ساعة',
                                      index: 1,
                                    ),
                                    CharacterTile(
                                      imagePath: 'assets/images/man11.png',
                                      title: 'عنترة بن شداد',
                                      category: 'العلوم والمعرفة',
                                      time: 'ساعة',
                                      index: 1,
                                    ),
                                    CharacterTile(
                                      imagePath: 'assets/images/man12.png',
                                      title: 'حي بن يقظان',
                                      category: 'العلوم والمعرفة',
                                      time: 'ساعة',
                                      index: 1,
                                    ),
                                    CharacterTile(
                                      imagePath: 'assets/images/man3.webp',
                                      title: 'حي بن يقظان',
                                      category: 'الأدب والشعر',
                                      time: 'ساعة',
                                      index: 1,
                                    ),
                                    CharacterTile(
                                      imagePath: 'assets/images/man2.png',
                                      title: 'بن سينا',
                                      category: 'الطب والفلسفة',
                                      time: 'ساعة',
                                      index: 1,
                                    ),
                                    CharacterTile(
                                      imagePath: 'assets/images/man.png',
                                      title: 'الخوارزمي',
                                      category: 'العلوم والمعرفة',
                                      time: 'ساعة',
                                      index: 1,
                                    ),
                                    CharacterTile(
                                      imagePath: 'assets/images/man11.png',
                                      title: 'عنترة بن شداد',
                                      category: 'العلوم والمعرفة',
                                      time: 'ساعة',
                                      index: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: GetBuilder<ExploreScreenController>(
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
                    ))),
      ),
    );
  }

  Widget _buildConsultationHighlights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أبرز الاستشارات',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        // Wrap GridView with Container and define height to avoid RenderBox issue
        Container(
          height: 300, // Adjust as needed
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2.5,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Chip(
                              label: Text('استشارة',
                                  style: TextStyle(color: Colors.orange))),
                          SizedBox(width: 4),
                          Chip(
                              label: Text('التجارة',
                                  style: TextStyle(color: Colors.blue))),
                        ],
                      ),
                      Text('كيف استثمر؟',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text('11.12.2024', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'تصفح'),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat, size: 40, color: Colors.blue),
          label: '',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'مكتبتي'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
      ],
      onTap: (index) {
        // Handle navigation based on index
      },
      showUnselectedLabels: true,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
    );
  }
}

class CharacterTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String category;
  final String time;
  final int index; // Unique index for each tile

  CharacterTile({
    required this.imagePath,
    required this.title,
    required this.category,
    required this.time,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExploreScreenController>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(context, "/detls");
        },
        child: Container(
          width: 400,
          height: 120,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.grey[100],
            child: Container(
              height: 100,
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      side: BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text("ابدأ القراءة"),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '$time  •  $category',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.access_time,
                                size: 16, color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.fill,
                            width: 90,
                            height: 100,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          left: 4,
                          child: GestureDetector(
                            onTap: () => controller.toggleFavorite(index),
                            child: Obx(
                              () => CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.white.withOpacity(0.8),
                                child: Icon(
                                  controller.favoriteStatus[index]?.value ??
                                          false
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      controller.favoriteStatus[index]?.value ??
                                              false
                                          ? Colors.red
                                          : Colors.black,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
