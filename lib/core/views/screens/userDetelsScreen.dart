import 'package:get/get.dart';
import 'package:flutter/material.dart';

// user_model.dart
class UserModel {
  String name;
  String phone;
  String email;
  String imageUrl;

  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.imageUrl,
  });
}

// user_co

class UserController extends GetxController {
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
        Get.offNamed("/acu");
        break;
    }
  }

  var user = UserModel(
    name: 'فيصل',
    phone: '0451484311',
    email: 'Faisal.z2024@gmail.com',
    imageUrl: 'assets/images/men2.webp', // مسار الصورة الشخصية
  ).obs;

  void updateUser(String name, String phone, String email) {
    user.update((val) {
      val?.name = name;
      val?.phone = phone;
      val?.email = email;
    });
  }

  void updateUserImage(String imageUrl) {
    user.update((val) {
      val?.imageUrl = imageUrl;
    });
  }
}

class UserProfilePage extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerRight,
            child: Text('إعداد الحساب'),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() => CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage(userController.user.value.imageUrl),
                    )),
                SizedBox(height: 8),
                IconButton(
                  icon: Icon(Icons.camera_alt, color: Color(0xFF1C274C)),
                  onPressed: () {
                    // يمكن إضافة منطق لتحديث الصورة الشخصية هنا
                  },
                ),
                SizedBox(height: 16),
                buildTextField(
                  controller: nameController
                    ..text = userController.user.value.name,
                  labelText: 'إسمك',
                ),
                buildTextField(
                  controller: phoneController
                    ..text = userController.user.value.phone,
                  labelText: 'رقم الجوال',
                ),
                buildTextField(
                  controller: emailController
                    ..text = userController.user.value.email,
                  labelText: 'البريد الإلكتروني',
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    userController.updateUser(
                      nameController.text,
                      phoneController.text,
                      emailController.text,
                    );
                    Get.snackbar("تحديث ناجح", "تم تحديث المعلومات بنجاح",
                        snackPosition: SnackPosition.BOTTOM);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1C274C),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text('تحديث'),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: GetBuilder<UserController>(
          builder: (_) => BottomNavigationBar(
            currentIndex: userController.selectedIndexB,
            onTap: (index) => userController.changebottem(index),
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

  Widget buildTextField(
      {required TextEditingController controller, required String labelText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
