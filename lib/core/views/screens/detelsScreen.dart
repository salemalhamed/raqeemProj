// File: details_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raqeem/core/views/screens/homeScreen.dart';

class DetailsPageController extends GetxController {
  int selectedIndexB = 1;

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

  var selectedTab = 1.obs; // لمتابعة التبويب المختار
  int selectedIndex = 1;
}

class DetailsPage extends StatelessWidget {
  final DetailsPageController controller = Get.put(DetailsPageController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('جابر بن حيان'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xFF273570)),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: Column(
            children: [
              // الجزء العلوي: صورة، عنوان، وتفاصيل
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/man3.webp',
                        width: 150,
                        height: 160,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'عنترة بن شداد',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '(24)فصل',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Chip(
                                label: Text('قصة'),
                                backgroundColor: Colors.blue[50],
                              ),
                              SizedBox(width: 8),
                              Chip(
                                label: Text('تاريخ'),
                                backgroundColor: Colors.blue[50],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Text(
                                '4.9',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              // تبويبات "نبذة مختصرة" و "المواضيع"
              Container(
                color: Colors.grey[200],
                child: Obx(() => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TabButton(
                            title: 'المواضيع',
                            isSelected: controller.selectedTab.value == 1,
                            onTap: () => controller.selectedTab.value = 1,
                          ),
                          TabButton(
                            title: 'نبذة مختصرة',
                            isSelected: controller.selectedTab.value == 0,
                            onTap: () => controller.selectedTab.value = 0,
                          ),
                        ],
                      ),
                    )),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.selectedTab.value == 0) {
                    // محتوى تبويب "نبذة مختصرة"
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'قصة الفارس والشاعر عنترة... شداد، وهي تحكي عن شجاعته وحبه.',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  } else {
                    // محتوى تبويب "المواضيع"
                    return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Text('${index + 1}'),
                          ),
                          title: Text(
                            'حيث بدأت الحكاية',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'قصة الفارس والشاعر عنترة... شداد، وهي تحكي عن شجاعته وحبه.',
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            Get.to(TopicDetailPage(topicIndex: index + 1));
                          },
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
          bottomNavigationBar: GetBuilder<DetailsPageController>(
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
    );
  }
}

class TabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  TabButton(
      {required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF273570) : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class TopicDetailPage extends StatelessWidget {
  final int topicIndex;

  TopicDetailPage({required this.topicIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الموضوع $topicIndex'),
      ),
      body: Center(
        child: Text(
          'تفاصيل الموضوع $topicIndex',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
