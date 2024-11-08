// account_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raqeem/core/views/screens/splashScreen.dart';
import 'package:raqeem/core/views/screens/userDetelsScreen.dart';

class AccountController extends GetxController {
  int selectedIndex = 0;
  int selectedIndexB = 4;

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

  void changeTab(int index) {
    selectedIndex = index;
    update();
  }

  void showAboutDialog() {
    Get.defaultDialog(
      title: "عن رقيم",
      middleText:
          "رقيم هي منصة مبتكرة تعتمد على الذكاء الاصطناعي لإحياء شخصيات تاريخية عربية بارزة، مثل ابن سينا والخوارزمي، مما يتيح للمستخدمين فرصة التفاعل معهم بشكل مباشر.",
      textConfirm: "إغلاق",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }

  void showTermsDialog1() {
    Get.defaultDialog(
      title: "الشروط والأحكام",
      middleText:
          "باستخدامك لهذا التطبيق، فإنك توافق على جميع الشروط والأحكام الموضحة هنا. نحتفظ بحق تعديل هذه الشروط في أي وقت بدون إشعار مسبق.",
      textConfirm: "إغلاق",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }

  void logout() {
    Get.defaultDialog(
      title: "تأكيد تسجيل الخروج",
      middleText: "هل أنت متأكد من تسجيل الخروج؟",
      textCancel: "إلغاء",
      textConfirm: "تأكيد",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        print("تم تسجيل الخروج");
        Get.to(SplashScreen());
      },
      onCancel: () {},
    );
  }

  void showContactDialog2() {
    Get.defaultDialog(
      title: "للتواصل",
      middleText:
          "إذا كانت لديك أي استفسارات أو مشاكل، يرجى التواصل معنا عبر البريد الإلكتروني support@raqeem.com أو عبر الهاتف 0451484311.",
      textConfirm: "إغلاق",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }
}

class AccountScreen extends StatelessWidget {
  final AccountController controller = Get.put(AccountController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'حسابي',
            style: TextStyle(
                color: Color(0xFF313450),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF313450)),
        ),
        body: Column(
          children: [
            // User Profile Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                onTap: () {
                  Get.to(UserProfilePage());
                },
                child: Container(
                  height: 90,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Obx(() => ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage(userController.user.value.imageUrl),
                          ),
                          title: Text(
                            userController.user.value.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userController.user.value.phone),
                              Text(
                                userController.user.value.email,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ),
            ),
            // Menu Options
            SizedBox(
              height: 200,
              width: 380,
              child: Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () => controller.showAboutDialog(),
                        child: buildMenuItem("عن رقيم", Icons.info_outline,
                            () => controller.showAboutDialog()),
                      ),
                      SizedBox(height: 12),
                      InkWell(
                        onTap: () => controller.showTermsDialog1(),
                        child: buildMenuItem(
                            "الشروط والأحكام",
                            Icons.article_outlined,
                            () => controller.showTermsDialog1()),
                      ),
                      SizedBox(height: 12),
                      InkWell(
                        onTap: () => controller.showContactDialog2(),
                        child: buildMenuItem(
                            "للتواصل",
                            Icons.contact_support_outlined,
                            () => controller.showContactDialog2()),
                      ),
                      SizedBox(height: 12),
                      InkWell(
                        onTap: () => controller.logout(),
                        child: buildMenuItem("تسجيل الدخول", Icons.logout,
                            () => controller.logout(),
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<AccountController>(
          builder: (_) => BottomNavigationBar(
            currentIndex: controller.selectedIndexB,
            onTap: (index) => controller.changebottem(index),
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

  // Helper method to build each menu item
  Widget buildMenuItem(String title, IconData icon, VoidCallback onTap,
      {Color color = Colors.black}) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(icon, color: color),
          ),
          Text(title, style: TextStyle(fontSize: 16, color: color)),
        ],
      ),
    );
  }
}
