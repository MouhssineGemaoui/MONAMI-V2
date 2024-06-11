import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/core/class/statusrequest.dart';
import 'package:monami/core/constant/routes.dart';
import 'package:monami/core/function/handlingDatacontroller.dart';
import 'package:monami/core/services/services.dart';
import 'package:monami/app_link.dart';
import 'package:monami/main.dart';
import 'package:monami/teachers/auth/data/datasource/remote/login_page_tearchers_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

abstract class LoginProfcontroller extends GetxController {
LoginProf();
}

class LoginProfcontrollerImp extends LoginProfcontroller {
GlobalKey<FormState> formstate = GlobalKey<FormState>();
LoginprofData loginprofData = LoginprofData(Get.find());

late TextEditingController email;
late TextEditingController password;

bool isshowpassword = true;
StatusRequest? statusRequest;

MyServices myServices = Get.find();

showPassword() {
isshowpassword = isshowpassword == true ? false : true;
update();
}

@override

LoginProf() async {
if (formstate.currentState!.validate()) {
statusRequest = StatusRequest.loading;
update();
var response = await loginprofData.postdata(password.text, email.text,);
statusRequest = handlingData(response);
if (StatusRequest.success == statusRequest) {
if (response['status'] == "success") {
// data.addAll(response['data']);
if(response['data']['prof_approve'].toString() == "1"){
// ignore: unused_local_variable
// String profid = myServices.sharedPreferences.getString("id")! ;
//print(response['data']);
myServices.sharedPreferences.setString("id", response['data']['prof_id'].toString()) ;
myServices.sharedPreferences.setString("username", response['data']['prof_name']) ;
myServices.sharedPreferences.setString("email", response['data']['prof_email']) ;
myServices.sharedPreferences.setString("subscriber_type", response['data']['subscriber_type'].toString());
myServices.sharedPreferences.setString("prof_image",response['data']['prof_image'].toString());
String image = myServices.sharedPreferences.getString("prof_image").toString();
      int secondsUsedinCall = 0;
       int TotalsecondsUsedinCall = 0;
       var userId = myServices.sharedPreferences.getString("id") ?? '';
       final firestoreInstance = FirebaseFirestore.instance;
      DateTime now = DateTime.now();
      String today = "${now.year}-${now.month}-${now.day}";
ZegoUIKitPrebuiltCallInvitationService().init(
    appID: 875055004 /*input your AppID*/,
    appSign: "58363f4b87ebe581fe502464ee8c0fcd92e59b4403648e9c9b756484cbf859af" /*input your AppSign*/,
    userID: response['data']['prof_id'].toString(),
    userName: response['data']['prof_name'] == null ? "" : response['data']['prof_name'].toString(),
    plugins: [ZegoUIKitSignalingPlugin()],
        invitationEvents: ZegoUIKitPrebuiltCallInvitationEvents(
              onIncomingCallAcceptButtonPressed: ()async{
                final userDailyLimitRef = await firestoreInstance.collection('TrackTeacherVideoCalls').doc(userId);
                 var userDailyLimitDoc = await userDailyLimitRef.get();    
                if (userDailyLimitDoc.exists) {
                   var userDoc = userDailyLimitDoc.data();
                   var lastUpdateDate = userDoc!['date'];
                  if (today == lastUpdateDate) {
      // If the last update was today, use the existing duration
                  TotalsecondsUsedinCall = userDoc['dailyDurationSeconds'] ?? 0;
                  } else {
      // If the last update was not today, reset the duration
                 TotalsecondsUsedinCall = 0;
                }
              }else{
                  await userDailyLimitRef.set({
                    'dailyDurationSeconds': 0,
                    'date': today,
                  });
                }
              },
            ),
            events: ZegoUIKitPrebuiltCallEvents(
              onCallEnd: (event, defaultAction)async{
                final userDailyLimitRef = await firestoreInstance.collection('TrackTeacherVideoCalls').doc(userId);
                int totalSeconds = TotalsecondsUsedinCall+secondsUsedinCall;
                secondsUsedinCall = 0;
                TotalsecondsUsedinCall = 0;
                 await userDailyLimitRef.set({
                 'dailyDurationSeconds': totalSeconds,
                 'date': today,
                 }, SetOptions(merge: true));
                  Get.offNamed(AppRoutes.Homescreenprof);
              },
            ),
            requireConfig: (ZegoCallInvitationData data) {
              var config = ZegoCallType.videoCall == data.type
                  ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                  : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

              config.duration.isVisible = true; 
              config.avatarBuilder = (BuildContext context, Size size,
        ZegoUIKitUser? user, Map extraInfo) {
      return user != null
          ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                   '${AppLink.imagesprof}/${image}',
                  ),
                ),
              ),
            )
          : const SizedBox();
    };
              config.duration.onDurationUpdate = (Duration duration) async {
                 var myServices = await SharedPreferences.getInstance();
                var subscriber_type = int.parse(myServices.getString('subscriber_type') ?? '0');
                // Update the document with new duration
                if (subscriber_type == 0) {
                  secondsUsedinCall += 1;
                  int remainingSeconds = 120 - (TotalsecondsUsedinCall+secondsUsedinCall);
                  if ( remainingSeconds == 10) { // Show warning before 10 seconds of limit
                    Get.dialog(
                     AlertDialog(
                     title: Text('Warning'),
                     content: Text('You have only 10 seconds left for today.'),
                    ),
                    barrierDismissible: false, // Prevents the dialog from being dismissed by tapping outside
                  );

                  // Wait for 2 seconds
                 await Future.delayed(Duration(seconds: 2));

  // Automatically close the dialog
                if(Get.isDialogOpen == true){
                Get.back();
                }
                  } else if (remainingSeconds <= 0) { // End call after limit is reached
                    if (navigatorKey.currentState != null) {
                      ZegoUIKitPrebuiltCallController().hangUp(navigatorKey.currentState!.context);
                      final userDailyLimitRef = await firestoreInstance.collection('TrackTeacherVideoCalls').doc(userId);
                      int totalSeconds = TotalsecondsUsedinCall+secondsUsedinCall;
                      secondsUsedinCall = 0;
                      TotalsecondsUsedinCall = 0;
                      await userDailyLimitRef.set({
                      'dailyDurationSeconds': totalSeconds,
                      'date': today,
                      }, SetOptions(merge: true));
                    }
                  }
                } else if(subscriber_type == 1) {
                  secondsUsedinCall += 1;
                  int remainingSeconds = (12*60) - (TotalsecondsUsedinCall+secondsUsedinCall);
                  if ( remainingSeconds == 10) { // Show warning before 10 seconds of limit
                    Get.dialog(
                     AlertDialog(
                     title: Text('Warning'),
                     content: Text('You have only 10 seconds left for today.'),
                    ),
                    barrierDismissible: false, // Prevents the dialog from being dismissed by tapping outside
                  );

                  // Wait for 2 seconds
                 await Future.delayed(Duration(seconds: 2));

  // Automatically close the dialog
                if(Get.isDialogOpen == true){
                Get.back();
                }
                  } else if (remainingSeconds <= 0) { // End call after limit is reached
                    if (navigatorKey.currentState != null) {
                      ZegoUIKitPrebuiltCallController().hangUp(navigatorKey.currentState!.context);
                      final userDailyLimitRef = await firestoreInstance.collection('TrackTeacherVideoCalls').doc(userId);
                      int totalSeconds = TotalsecondsUsedinCall+secondsUsedinCall;
                      secondsUsedinCall = 0;
                      TotalsecondsUsedinCall = 0;
                      await userDailyLimitRef.set({
                      'dailyDurationSeconds': totalSeconds,
                      'date': today,
                      }, SetOptions(merge: true));
                    }
                  }
                }else if(subscriber_type == 2) {
                  secondsUsedinCall += 1;
                  int remainingSeconds = (16*60) - (TotalsecondsUsedinCall+secondsUsedinCall);
                  if ( remainingSeconds == 10) { // Show warning before 10 seconds of limit
                    Get.dialog(
                     AlertDialog(
                     title: Text('Warning'),
                     content: Text('You have only 10 seconds left for today.'),
                    ),
                    barrierDismissible: false, // Prevents the dialog from being dismissed by tapping outside
                  );

                  // Wait for 2 seconds
                 await Future.delayed(Duration(seconds: 2));

  // Automatically close the dialog
                if(Get.isDialogOpen == true){
                Get.back();
                }
                  } else if (remainingSeconds <= 0) { // End call after limit is reached
                    if (navigatorKey.currentState != null) {
                      ZegoUIKitPrebuiltCallController().hangUp(navigatorKey.currentState!.context);
                      final userDailyLimitRef = await firestoreInstance.collection('TrackTeacherVideoCalls').doc(userId);
                      int totalSeconds = TotalsecondsUsedinCall+secondsUsedinCall;
                      secondsUsedinCall = 0;
                      TotalsecondsUsedinCall = 0;
                      await userDailyLimitRef.set({
                      'dailyDurationSeconds': totalSeconds,
                      'date': today,
                      }, SetOptions(merge: true));
                    }
                  }
                }else if(subscriber_type == 3) {
                  secondsUsedinCall += 1;
                  int remainingSeconds = (24*60) - (TotalsecondsUsedinCall+secondsUsedinCall);
                  if ( remainingSeconds == 10) { // Show warning before 10 seconds of limit
                    Get.dialog(
                     AlertDialog(
                     title: Text('Warning'),
                     content: Text('You have only 10 seconds left for today.'),
                    ),
                    barrierDismissible: false, // Prevents the dialog from being dismissed by tapping outside
                  );

                  // Wait for 2 seconds
                 await Future.delayed(Duration(seconds: 2));

  // Automatically close the dialog
                if(Get.isDialogOpen == true){
                Get.back();
                }
                  } else if (remainingSeconds <= 0) { // End call after limit is reached
                    if (navigatorKey.currentState != null) {
                      ZegoUIKitPrebuiltCallController().hangUp(navigatorKey.currentState!.context);
                      final userDailyLimitRef = await firestoreInstance.collection('TrackTeacherVideoCalls').doc(userId);
                      int totalSeconds = TotalsecondsUsedinCall+secondsUsedinCall;
                      secondsUsedinCall = 0;
                      TotalsecondsUsedinCall = 0;
                      await userDailyLimitRef.set({
                      'dailyDurationSeconds': totalSeconds,
                      'date': today,
                      }, SetOptions(merge: true));
                    }
                  }
                }
              };
              return config;
            },
  ); 

myServices.sharedPreferences.setString("step","5") ;
Get.offNamed(AppRoutes.Homescreenprof);

}
} else {
Get.defaultDialog(title: 'Warning', middleText: 'not connect');
statusRequest = StatusRequest.failute;
}
}
update();
}
}


@override
void onInit() {
email = TextEditingController();
password = TextEditingController();
super.onInit();
}

@override
void dispose() {
email.dispose();
password.dispose();
super.dispose();
}

}