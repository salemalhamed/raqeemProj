import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabControllerX extends GetxController {
  int selectedIndexB = 3;

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

  var currentIndex = 0.obs;

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}

class LibraryScreen extends StatelessWidget {
  final TabControllerX tabController = Get.put(TabControllerX());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('مكتبتي', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            // Tab bar for switching categories
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildTabButton("الاستشارات", 0),
                  buildTabButton("القصص", 1),
                  buildTabButton("الكلمات", 2),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                switch (tabController.currentIndex.value) {
                  case 0:
                    return cardd();
                  case 1:
                    return cardd2();
                  case 2:
                    return cardd3();
                  default:
                    return cardd();
                }
              }),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<TabControllerX>(
          builder: (_) => BottomNavigationBar(
            currentIndex: tabController.selectedIndexB,
            onTap: (index) => tabController.changebottem(index),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "الرئيسية"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "تصفح"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat, size: 40), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: "مكتبتي"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
            ],
            selectedItemColor: Color(0xFF273570),
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }

  // Build tab button with selection handling
  Widget buildTabButton(String title, int index) {
    return Obx(() {
      bool isSelected = tabController.currentIndex.value == index;
      return GestureDetector(
        onTap: () {
          tabController.changeTabIndex(index);
        },
        child: Container(
          width: 100,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isSelected
                ? Color(0xFF273470)
                : const Color.fromARGB(255, 255, 255, 255),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: isSelected
                  ? Color.fromARGB(255, 255, 255, 255)
                  : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      );
    });
  }

  // Tab content for "Consultations"
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
    final controller = Get.find<TabControllerX>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
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
                        Icon(Icons.access_time, size: 16, color: Colors.grey),
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
                        width: 80,
                        height: 80,
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
                              controller.favoriteStatus[index]?.value ?? false
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: controller.favoriteStatus[index]?.value ??
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
    );
  }
}

Widget cardd() {
  return SizedBox(
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
          ],
        ),
      ),
    ),
  );
}

Widget cardd2() {
  return SizedBox(
    height: 500,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: SingleChildScrollView(
        child: Column(
          children: [
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
  );
}

Widget cardd3() {
  return SizedBox(
    height: 500,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: SingleChildScrollView(
        child: Column(
          children: [
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
  );
}
