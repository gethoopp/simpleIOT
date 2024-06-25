 import 'package:get/get.dart';
import 'package:simple_iot/view/auth/login.dart';
import 'package:simple_iot/view/details/conditioner.dart';
import 'package:simple_iot/view/details/ceil.dart';
import 'package:simple_iot/view/details/lamp.dart';
import 'package:simple_iot/widget/navbar.dart';

appRoute() => [
  GetPage(name: '/ceil' , page: () => const Detail1()),
  GetPage(name: '/conditioner' , page: () => const Detail2()),
  GetPage(name: '/lamp' , page: () => const Detail3()),
  GetPage(name: '/cooler' , page: () => const Detail1()),
  GetPage(name: '/home' , page: () => const Navbar()),
  GetPage(name: '/login' , page: () => const LoginPage()),
 ];