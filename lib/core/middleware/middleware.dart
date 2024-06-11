import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/students/auth/controller/authcontroller.dart';
import 'package:monami/core/constant/routes.dart';
import 'package:monami/core/services/services.dart';
import 'package:monami/app_link.dart';
import 'package:monami/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class MyMiddleware extends GetMiddleware {
  int? get priority => 1;

  MyServices myServices = Get.find();
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString('step') == "3") {
      return RouteSettings(name: AppRoutes.add_edata_users);
    }
     if (myServices.sharedPreferences.getString('step') == "4") {
       int secondsUsedinCall = 0;
       int TotalsecondsUsedinCall = 0;
       var userId = myServices.sharedPreferences.getString("id") ?? '';
       final firestoreInstance = FirebaseFirestore.instance;
       String image = myServices.sharedPreferences.getString("users_image").toString();
      DateTime now = DateTime.now();
      String today = "${now.year}-${now.month}-${now.day}";
       ZegoUIKitPrebuiltCallInvitationService().init(
            appID: 875055004, // your AppID
            appSign: "58363f4b87ebe581fe502464ee8c0fcd92e59b4403648e9c9b756484cbf859af", // your AppSign
            userID: myServices.sharedPreferences.getString("id").toString(),
            userName: myServices.sharedPreferences.getString("users_name").toString(),
            plugins: [ZegoUIKitSignalingPlugin()],
            invitationEvents: ZegoUIKitPrebuiltCallInvitationEvents(
              onOutgoingCallAccepted:(callID, callee)async{
                print("image is ${AppLink.imagesprof}/${image}");
                 final userDailyLimitRef = await firestoreInstance.collection('TrackStudentVideoCalls').doc(userId);
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
                final userDailyLimitRef = await firestoreInstance.collection('TrackStudentVideoCalls').doc(userId);
                int totalSeconds = TotalsecondsUsedinCall+secondsUsedinCall;
                secondsUsedinCall = 0;
                TotalsecondsUsedinCall = 0;
                 await userDailyLimitRef.set({
                 'dailyDurationSeconds': totalSeconds,
                 'date': today,
                 }, SetOptions(merge: true));
                 Get.offNamed(AppRoutes.homepage);
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
                      final userDailyLimitRef = await firestoreInstance.collection('TrackStudentVideoCalls').doc(userId);
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
                      final userDailyLimitRef = await firestoreInstance.collection('TrackStudentVideoCalls').doc(userId);
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
                      final userDailyLimitRef = await firestoreInstance.collection('TrackStudentVideoCalls').doc(userId);
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
                      final userDailyLimitRef = await firestoreInstance.collection('TrackStudentVideoCalls').doc(userId);
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
      return RouteSettings(name: AppRoutes.homepage);
    }
    
     if (myServices.sharedPreferences.getString('step') == "5") {
      int secondsUsedinCall = 0;
       int TotalsecondsUsedinCall = 0;
       var userId = myServices.sharedPreferences.getString("id") ?? '';
       String image = myServices.sharedPreferences.getString("prof_image").toString();
       final firestoreInstance = FirebaseFirestore.instance;
        DateTime now = DateTime.now();
      String today = "${now.year}-${now.month}-${now.day}";
       ZegoUIKitPrebuiltCallInvitationService().init(
     appID: 875055004 /*input your AppID*/,
    appSign: "58363f4b87ebe581fe502464ee8c0fcd92e59b4403648e9c9b756484cbf859af" /*input your AppSign*/,
    userID: myServices.sharedPreferences.getString("id").toString(),
    userName: myServices.sharedPreferences.getString("username").toString(),
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
      return RouteSettings(name: AppRoutes.Homescreenprof);
    }


    if (myServices.sharedPreferences.getString('step') == "1") {
      return RouteSettings(name: AppRoutes.login);
    }
    
    if (myServices.sharedPreferences.getString('step') == "2") {
      return RouteSettings(name: AppRoutes.LoginProf);
    
    }
    return null;
  }
}
