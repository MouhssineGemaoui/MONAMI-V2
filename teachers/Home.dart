import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/teachers/home/controller/DRAWER.dart';
import 'package:monami/students/auth/controller/login_controller.dart';
import 'package:monami/core/constant/app_color.dart';
import 'package:monami/core/constant/routes.dart';
import 'package:monami/students/messages/views/widget/ChatList.dart';
import 'package:monami/students/messages/views/pages/messages_page_students.dart';
import 'package:monami/teachers/home/views/pages/home_page_tearchers.dart';
import 'package:monami/teachers/profile/views/pages/page_profile_teachers.dart';
import 'package:monami/students/auth/views/widget/cstmBottomAuth.dart';

class Homescrenprof extends StatefulWidget {
  const Homescrenprof({super.key});

  @override
  State<Homescrenprof> createState() => _HomescrenprofState();
}

class _HomescrenprofState extends State<Homescrenprof> {
  int _selectedIndex = 0;
  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  List<Widget> _widgetOptions = <Widget>[
    HomePageTearchers(),
    ChatList(),
    PageProfileTeachers(),
  ];
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    appareprofcontroller controolerdrw = Get.put(appareprofcontroller());
    LogincontrollerImp controller = Get.put(LogincontrollerImp());
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
              Navigator.of(context).pushNamed('notification');
            },
          ),
        ],
        flexibleSpace: Container(
            margin: EdgeInsets.only(top: 40),
            height: 150,
            width: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/monami.png'),
                  fit: BoxFit.fitHeight),
            )),
        elevation: 0,

      ),
      drawerScrimColor: AppColor.buttommonami.withOpacity(0.2),

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
            label: 'Home',
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
            label: 'Message',
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
              label: 'Profile'),
        ],
        selectedIndex: _selectedIndex,
        // onTabChange: (index) {
        //   setState(() {
        //     _selectedIndex = index;
        //   });
        // },
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          AppColor.black,
          AppColor.white,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
