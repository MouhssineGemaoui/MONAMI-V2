import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/students/auth/controller/login_controller.dart';
import 'package:monami/students/profile/controller/get_profile_page_students_controller.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/core/constant/routes.dart';
import 'package:monami/students/home/views/pages/home_page.dart';
import 'package:monami/students/messages/views/pages/messages_page_students.dart';
import 'package:monami/students/favorites/views/pages/favorite_page.dart';
import 'package:monami/students/profile/views/pages/profile_page_students.dart';
import 'package:monami/students/search/views/pages/search_page_students.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  List _pages = [
    HomePage(),
    SearchPageStudents(),
    MyFavorite(),
    MessagesPageStudents(),
    ProfilePageStudents(),
  ];
  @override
  Widget build(BuildContext context) {

    LogincontrollerImp controller = Get.put(LogincontrollerImp());
    Get.put(GetProfilePageStudentsControllerImp());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined,
                color: AppColor.buttommonami),
            onPressed: () {
              Get.toNamed(AppRoutes.notifusers);
            },
          ),
        ],
        flexibleSpace: Container(
            margin: EdgeInsets.only(top: 50),
            height: 150,
            width: 250,
            decoration: const BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage('images/monami.png'),
                  fit: BoxFit.fitHeight),
            )),
        elevation: 0,
        // leading: Builder(builder: (context) {
        //   return IconButton(
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //       icon: Icon(
        //         Icons.menu,
        //       ),
        //       color: AppColor.buttommonami);
        // }),
      ),


//    bottomNavigationBar: Container(
//         // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         decoration:  BoxDecoration(
// color: Colors.white,
//           boxShadow : [  BoxShadow(blurRadius:30,
//           color: Color.fromARGB(255, 0, 0, 0),
//           offset: Offset(0, 20) )
//         ]),
//         child: ClipRRect(
          
//           borderRadius: BorderRadius.circular(30),
//           child: BottomNavigationBar(
//             currentIndex: _selectedIndex ,
//             backgroundColor: Color.fromARGB(255, 0, 0, 0),
//             selectedItemColor: const Color.fromARGB(255, 29, 26, 26),
//             unselectedItemColor: Colors.black12,
//           selectedFontSize: 12,
//           onTap: (Index) {
//             setState(() {
//               _selectedIndex = Index ;
//             });
//           },

//             items:  [
//                  BottomNavigationBarItem(icon:  Icon( Icons.home_outlined) , label: '12'.tr,  ),
//                  BottomNavigationBarItem(icon:  Icon( Icons.search_outlined) , label: '13'.tr,  ),
//                  BottomNavigationBarItem(icon:  Icon( Icons.favorite_outline) , label: '16'.tr,  ),
//                  BottomNavigationBarItem(icon:  Icon( Icons.message_outlined) , label: '14'.tr,  ),
//                  BottomNavigationBarItem(icon:  Icon( Icons.person_outlined) , label: '15'.tr,  ),
//                  ] ),
//         ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        onDestinationSelected: (_selectedIndex) => setState(
          () => this._selectedIndex = _selectedIndex,
        ),
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: AppColor.buttommonami,
            ),
            selectedIcon: Icon(
              Icons.home,
              color: AppColor.buttommonami,
            ),
            label: '12'.tr,
          ),
          NavigationDestination(
            icon: Icon(
              Icons.search_outlined,
              color: AppColor.buttommonami,
            ),
            selectedIcon: Icon(
              Icons.search,
              color: AppColor.buttommonami,
            ),
            label: '13'.tr,
          ),
          NavigationDestination(
            icon: Icon(
              Icons.favorite_outline,
              color: AppColor.buttommonami,
            ),
            selectedIcon: Icon(
              Icons.favorite,
              color: AppColor.buttommonami,
            ),
            label: '16'.tr,
          ),
          NavigationDestination(
            icon: Icon(
              Icons.message_outlined,
              color: AppColor.buttommonami,
            ),
            selectedIcon: Icon(
              Icons.message,
              color: AppColor.buttommonami,
            ),
            label: '14'.tr,
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_outlined,
              color: AppColor.buttommonami,
            ),
            selectedIcon: Icon(
              Icons.person,
              color: AppColor.buttommonami,
            ),
            label: '15'.tr,
          ),
        ],
        selectedIndex: _selectedIndex,
        // onTabChange: (index) {
        //   setState(() {
        //     _selectedIndex = index;
        //   });
        // },
      ),
      body:  _pages.elementAt(_selectedIndex),
      
    );
  }
}
