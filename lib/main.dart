import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:simple_iot/controller/notification.dart';
import 'package:simple_iot/controller/routes.dart';
import 'package:simple_iot/cubit/auth_cubit_cubit.dart';
import 'package:simple_iot/firebase_options.dart';
import 'package:simple_iot/view/auth/regist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  NotificationLoc.initialize;
  NotificationLoc.createPermissions;

  runApp(const SimpleIot());
}

class SimpleIot extends StatelessWidget {
  const SimpleIot({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent),
      child: BlocProvider(
        create: (context) => AuthCubitCubit(),
        child: GetMaterialApp(
          getPages: appRoute(),
          home: const RegistPage(),
        ),
      ),
    );
  }
}
