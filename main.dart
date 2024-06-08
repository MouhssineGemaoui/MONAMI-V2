import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/bindings/initialBinding.dart';
import 'package:monami/students/auth/controller/authcontroller.dart';
import 'package:monami/core/Languages/changelocal.dart';
import 'package:monami/core/services/services.dart';
import 'package:monami/firebase_options.dart';
import 'package:monami/routes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'core/Languages/translation.dart';

late SharedPreferences sharedPref ; 
var uuid = Uuid();
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> requestPermissions() async {
  await [Permission.microphone, Permission.camera].request();
}

void main() async {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await InitialiServices();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  ); 
  Get.put(AuthController());
  await requestPermissions();
  final authController = Get.find<AuthController>();
  //  ZegoUIKitPrebuiltCallInvitationService().init(
  //   appID: 875055004 /*input your AppID*/,
  //   appSign: "58363f4b87ebe581fe502464ee8c0fcd92e59b4403648e9c9b756484cbf859af" /*input your AppSign*/,
  //   userID: '14',
  //   userName: 'khalid',
  //   plugins: [ZegoUIKitSignalingPlugin()],
  //   requireConfig: (ZegoCallInvitationData data) {
  //   var config = (data.invitees.length > 1)
  //       ? ZegoCallType.videoCall == data.type
  //           ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
  //           : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
  //       : ZegoCallType.videoCall == data.type
  //           ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
  //           : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

  //   // Modify your custom configurations here.
  //  config.duration.isVisible = true;
  //  config.duration.onDurationUpdate = (Duration duration)async{
  //          if (duration.inSeconds >= 2 * 60) {
  //          //await Future.delayed(Duration(milliseconds: 500)); // Optional delay
  //          try {
  //          ZegoUIKitPrebuiltCallController().hangUp(navigatorKey.currentState!.context);
  //          } catch (error) {
  //         print("Error hanging up call: $error");
  //         }
  // }
  //   };
  //   return config;
  // },
  // ); 
  /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  ZegoUIKit().init(
    appID: 875055004 /*input your AppID*/,
    appSign: "58363f4b87ebe581fe502464ee8c0fcd92e59b4403648e9c9b756484cbf859af",
    scenario: ZegoScenario.StandardVideoCall,
  );
  ZegoUIKit().initLog().then((value) {
    ///  Call the `useSystemCallingUI` method
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(MyApp(navigatorKey: navigatorKey));
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  MyApp({required this.navigatorKey});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    return GetMaterialApp(
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: controller.language,
      theme: controller.appTheme,
      // home: depar(),
      // initialBinding: Mybinding(),
      initialBinding:  initialBindings(),
      // routes: routes,
      getPages: routes,
      navigatorKey: widget.navigatorKey,
    );
  }
}
