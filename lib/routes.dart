import 'package:get/get.dart';
import 'package:monami/core/constant/routes.dart';
import 'package:monami/core/middleware/middleware.dart';
import 'package:monami/students/Terms_of_students.dart';
import 'package:monami/students/abonnement/view/screen/abonnement_page.dart';
import 'package:monami/teachers/home/views/pages/show_page_profile_teachers.dart';
import 'package:monami/teachers/profile/views/pages/customer_services_teachres.dart';
import 'package:monami/teachers/profile/views/pages/edit_page_profile_teachers.dart';
import 'package:monami/students/profile/views/pages/edit_profile_page_students.dart';
import 'package:monami/students/home/views/pages/page_show_more_teachers_english.dart';
import 'package:monami/students/favorites/views/pages/favorite_page.dart';
import 'package:monami/students/home/views/pages/page_profile_prof.dart';
import 'package:monami/students/favorites/views/pages/page_profile_prof_favorite.dart';
import 'package:monami/students/home/views/pages/page_show_more_teachers_french.dart';
import 'package:monami/core/shared/language.dart';
import 'package:monami/students/profile/views/pages/customer_services_students.dart';
import 'package:monami/core/shared/login_as_student_or_teacher.dart';
import 'package:monami/core/shared/first_page.dart';
import 'package:monami/teachers/Home.dart';
import 'package:monami/teachers/home/views/pages/home_page_tearchers.dart';
import 'package:monami/teachers/home/views/pages/page_show_more_users.dart';
import 'package:monami/teachers/auth/views/pages/login_page_tearcher.dart';
import 'package:monami/students/home_screen_student.dart';
import 'package:monami/students/auth/views/pages/forgetPassword/forget_Password.dart';
import 'package:monami/students/auth/views/pages/verfiycodesignup.dart';
import 'package:monami/students/auth/views/pages/login.dart';
import 'package:monami/students/auth/views/pages/forgetPassword/resetpassword.dart';
import 'package:monami/students/auth/views/pages/forgetPassword/successResetPassword.dart';
import 'package:monami/students/auth/views/pages/success_Singup.dart';
import 'package:monami/students/auth/views/pages/forgetPassword/verfiycode.dart';
import 'package:monami/students/profile/views/pages/profile_page_students.dart';
import 'package:monami/students/auth/views/pages/SignUp.dart';


List<GetPage<dynamic>>? routes = [
GetPage(name: "/", page: () =>const FirstPage() , middlewares: [
  MyMiddleware()
] ),
GetPage(name: AppRoutes.login, page: ()               =>const Login() ),
GetPage(name: AppRoutes.singUp, page: ()              =>const SignUp() ),
GetPage(name: AppRoutes.verfiycode, page: ()          =>const VerfiyCode() ),
GetPage(name: AppRoutes.ResetPassword, page: ()       =>const ResetPassword() ),
GetPage(name: AppRoutes.forgetPassword, page: ()      =>const ForgetPassword() ),
GetPage(name: AppRoutes.successResetPassword, page:() =>const SuccessResetPassword() ),
GetPage(name: AppRoutes.successSignup, page: ()       =>const SuccessSignup() ),
GetPage(name: AppRoutes.verfiycodesignup, page: ()    =>const Verfiycodesignup() ),
///////////////////////////// SCREEN ///////////////////////////////
GetPage(name: AppRoutes.homepage, page: ()          =>const HomeScreen()),
//////////////////////////// onBoarding ///////////////////////////////
GetPage(name: AppRoutes.PageProfileProf,page:()   =>const PageProfileProf()),
GetPage(name: AppRoutes.usersprofileDetails,page:()   =>const usersprofileDetails()),
GetPage(name: AppRoutes.ProducteDetailsFav,page:()=>const ProducteDetailsFav()),
GetPage(name: AppRoutes.MyFavorite, page: ()      =>const MyFavorite()),
GetPage(name: AppRoutes.PageShowMoreProfEnglish, page: ()        =>const PageShowMoreProfEnglish()),
GetPage(name: AppRoutes.PageShowMoreProfFrench, page: ()        =>const PageShowMoreProfFrench()),
GetPage(name: AppRoutes.chesirLogin, page: ()     =>const chesirLogin()),
GetPage(name: AppRoutes.LoginProf, page: ()       =>const LoginProf()),

//  profile_page_students

GetPage(name: AppRoutes.ProfilePageStudents, page: ()      =>const ProfilePageStudents()),
GetPage(name: AppRoutes.EditProfilePageStudents, page: ()            =>const EditProfilePageStudents()),
GetPage(name: AppRoutes.CustomerServicesStudents,  page: () =>const CustomerServicesStudents()),
GetPage(name: AppRoutes.Languages,        page: () =>const Languages()),


GetPage(name: AppRoutes.abonnement, page: ()      =>const AbonnementPage()),


// ! prof

GetPage(name: AppRoutes.HomePageTearchers,    page: () =>const HomePageTearchers()),
GetPage(name: AppRoutes.Homescreenprof,  page: () =>const Homescrenprof()),
GetPage(name: AppRoutes.EditPageProfileTeachers, page: () =>const EditPageProfileTeachers()),
GetPage(name: AppRoutes.PageShowMoreUsers,   page: () =>const PageShowMoreUsers()),
GetPage(name: AppRoutes.CustomerServicesTeachres,     page: () =>const CustomerServicesTeachres()),
GetPage(name: AppRoutes.TermsOfStudent,     page: () =>const TermsOfStudent()),

];
