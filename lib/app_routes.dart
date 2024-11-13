import 'package:get/get.dart';

// Main routes packages
import 'package:rehand/views/screens/auth/starting_page.dart';
import 'package:rehand/views/screens/auth/create_account.dart';
import 'package:rehand/views/screens/auth/login_page.dart';
import 'package:rehand/views/screens/auth/logout_page.dart';
import 'package:rehand/views/screens/auth/reset_password.dart';
import 'package:rehand/views/screens/doctor/chat/display_patients.dart';
import 'package:rehand/views/screens/doctor/home_doc.dart';
import 'package:rehand/views/screens/doctor/main_screen_doctor.dart';
import 'package:rehand/views/screens/patient/chat/ai_assistant.dart';
import 'package:rehand/views/screens/patient/chat/chat.dart';
import 'package:rehand/views/screens/patient/chat/display_doctors.dart';
import 'package:rehand/views/screens/patient/connect2.dart';
import 'package:rehand/views/screens/patient/connect_page.dart';
import 'package:rehand/views/screens/patient/dashboard.dart';
import 'package:rehand/views/screens/patient/exercises/exercise1.dart';
import 'package:rehand/views/screens/patient/exercises/exercise2.dart';
import 'package:rehand/views/screens/patient/goal.dart';
import 'package:rehand/views/screens/patient/goal2.dart';

import 'package:rehand/views/screens/patient/home_patient.dart';
import 'package:rehand/views/screens/patient/main_screen.dart';

List<GetPage> get appRoutes => [
      //Auth screens
      GetPage(name: '/startingPage', page: () => const StartingPage()),
      GetPage(name: '/createAccount', page: () => const CreateAccount()),
      GetPage(name: '/login', page: () => const LoginPage()),
      GetPage(name: '/logout', page: () => const LogOut()),
      GetPage(name: '/resetPass', page: () => const ResetPassword()),
      //Patient screens
      GetPage(name: '/goal', page: () => const ChooseGoal()),
      GetPage(name: '/goal2', page: () => const ChooseGoal2()),
      GetPage(name: '/connectGlove', page: () => const ConnectGlove()),
      GetPage(name: '/connect2', page: () => const Connect2()),
      GetPage(name: '/mainPat', page: () => const MainScreen()),
      GetPage(name: '/homePat', page: () => const HomePat()),
      GetPage(name: '/dashPatient', page: () => const Dash()),
      GetPage(name: '/ChatPat', page: () => const Chat()),
      GetPage(name: '/displayDoctors', page: () => DisplayDoctors()),
      GetPage(name: '/AI', page: () => const GeminiChat()),
      //exercises
      GetPage(name: '/Exercise1', page: () => const Exercise1()),
      GetPage(name: '/Exercise2', page: () => const Exercise2()),

      //Doctor screens
      GetPage(name: '/mainDoc', page: () => const MainScreenDoc()),
      GetPage(name: '/homeDoc', page: () => HomeDoc()),
      GetPage(name: '/displayPatient', page: () => DisplayPatient()),
      //GetPage(name: '/addPat', page: () => AddPatientScreen()),
    ];
